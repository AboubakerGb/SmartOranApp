from flask import Flask, render_template, request, redirect, url_for, make_response, jsonify
from auth import generate_token,verify_token
from bdd import *
app = Flask(__name__)
init_app(app)
app.secret_key = "123456789" # temp key


@app.route('/')
def index():
    return redirect(url_for('dashboard_login'))

# api for mobile app for all stations
@app.route('/api/bus_stations', methods=['GET'])
def get_bus_stations():
    print("bus")
    stations = db.session.query(Station).join(Type).filter(Type.name == 'bus').all()
    return jsonify([
        {
            'id': s.id,
            'name': s.name,
            'latitude': s.latituded,
            'longitude': s.longitude,
        } for s in stations
    ])
@app.route('/api/taxi_stations', methods=['GET'])
def get_taxi_stations():
    print("taxi")
    stations = db.session.query(Station).join(Type).filter(Type.name == 'taxi').all()
    return jsonify([
        {
            'id': s.id,
            'name': s.name,
            'latitude': s.latituded,
            'longitude': s.longitude,
        } for s in stations
    ])
@app.route('/api/tram_stations', methods=['GET'])
def get_tram_stations():
    print("tram")
    stations = db.session.query(Station).join(Type).filter(Type.name == 'tram').all()
    return jsonify([
        {
            'id': s.id,
            'name': s.name,
            'latitude': s.latituded,
            'longitude': s.longitude,
        } for s in stations
    ])

# api for mobile app for events / parking stations / reports
@app.route('/api/events', methods=['GET', 'POST'])
def get_add_events():
    if request.method =='GET':
        events = db.session.query(Events).all()
        return jsonify([
            {
                'id': e.id,
                'name': e.name,
                'location': e.location,
                'date_start': e.date_start.strftime('%Y-%m-%d'),
                'date_end': e.date_end.strftime('%Y-%m-%d'),
            } for e in events
        ])
    if request.method == 'POST':
        data = request.get_json()
        name = data.get('name')
        location = data.get('location')
        date_start = data.get('date_start')
        date_end = data.get('date_end')

        if not name or not location or not date_start or not date_end:
            return jsonify({'error': 'Missing data'}), 400

        new_event = Events(
            name=name,
            location=location,
            date_start=date_start,
            date_end=date_end
        )
        db.session.add(new_event)
        db.session.commit()
        return "sucess"
@app.route('/api/parking_stations', methods=['GET'])
def get_parking_stations():
    stations = db.session.query(Parking).all()
    return jsonify([
        {
            'id': s.id,
            'name': s.name,
            'latitude': s.latituded,
            'longitude': s.longitude,
            'available_places': s.available_places
        } for s in stations
    ])
@app.route('/api/report', methods=['POST'])
def submit_report():
    data = request.get_json()
    report_text = data.get('report')

    if not report_text:
        return jsonify({'error': 'Missing report data'}), 400

    try:
        new_report = Report(report=report_text)
        db.session.add(new_report)
        db.session.commit()
        return jsonify({'message': 'Report submitted successfully'}), 201
    except Exception as e:
        print("Error submitting report:", e)
        return jsonify({'error': 'Server error'}), 500

# api for mobile app for login (fonctionnelle)
@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()

    email = data.get('email')
    password = data.get('password')
    print("email - password ",email,password)
    if not email or not password:
        return jsonify({'error': 'Email and password are required'}), 400

    try:
        user = AppUser.query.filter_by(email=email).first()
        if user and user.password == password:
            return jsonify({'message': 'Login successful'}), 200
        else:
            return jsonify({'error': 'Invalid email or password'}), 401

    except Exception as e:
        print("Error during login:", e)
        return jsonify({'error': 'Server error'}), 500

# for wep app interfaces
@app.route('/dashboard-login', methods=['POST', 'GET'])
def dashboard_login():

    if request.method == 'POST':
        email = request.form.get('username')
        password = request.form.get('password')

        # Vérifiez les informations d'identification
        if verif_login(email, password):
            token = generate_token(email)
            resp = make_response(redirect(url_for('dashboard')))
            resp.set_cookie('token', token, httponly=True)  # Stocker le token dans un cookie sécurisé
            return resp
        else:
            # Retourne à la page de connexion avec un message d'erreur
            return render_template('login.html', error="Nom d'utilisateur ou mot de passe incorrect")

    # Affiche le formulaire de connexion
    return render_template('login.html')
@app.route('/dashboard')
def dashboard():
    token = request.cookies.get('token')
    if not token:
        return redirect(url_for('login'))  # Rediriger si pas de token
    user = verify_token(token)  # Si le token est bon il return le username
    if not user:
        return redirect(url_for('login'))  # Rediriger si token invalide ou expiré

    return render_template('dashboard.html', username=user)
@app.route('/logout')
def logout():
    resp = make_response(redirect(url_for('dashboard_login')))
    resp.set_cookie('token', '', expires=0)  # Supprimer le token
    return resp

if __name__ == '__main__':
    app.run(host="0.0.0.0",debug=True)



