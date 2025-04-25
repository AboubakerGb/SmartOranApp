from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

def init_app(app):
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost:3306/smartoran'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)

class Role(db.Model):
    __tablename__ = 'role'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Text, unique=True, nullable=False)

# 2. AppUser
class AppUser(db.Model):
    __tablename__ = 'appuser'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Text, nullable=False)
    lname = db.Column(db.Text, nullable=False)
    password = db.Column(db.Text, nullable=False)
    phone = db.Column(db.Text)
    email = db.Column(db.Text, unique=True)
    id_role = db.Column(db.Integer, db.ForeignKey('role.id'))

    role = db.relationship('Role', backref=db.backref('appuser', lazy=True))

# 3. Type
class Type(db.Model):
    __tablename__ = 'type'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Text, nullable=False)

# 4. Vehicle
class Vehicle(db.Model):
    __tablename__ = 'vehicle'
    id = db.Column(db.Integer, primary_key=True)
    id_driver = db.Column(db.Integer, db.ForeignKey('driver.id'))
    license_plate = db.Column(db.Text, unique=True)
    id_type = db.Column(db.Integer, db.ForeignKey('type.id'))
    registration_document = db.Column(db.Text)

    # Spécifie foreign_keys ici
    driver = db.relationship('Driver', backref=db.backref('vehicles', lazy=True), foreign_keys=[id_driver])
    type = db.relationship('Type', backref=db.backref('vehicles', lazy=True))

# 5. Driver
class Driver(db.Model):
    __tablename__ = 'driver'
    id = db.Column(db.Integer, primary_key=True)
    id_user = db.Column(db.Integer, db.ForeignKey('appuser.id', ondelete='CASCADE'))
    id_vehicle = db.Column(db.Integer, db.ForeignKey('vehicle.id'))
    driver_license = db.Column(db.Text)
    national_id = db.Column(db.Text)
    job_license = db.Column(db.Text)

    user = db.relationship('AppUser', backref=db.backref('drivers', lazy=True))
    vehicle = db.relationship('Vehicle', backref=db.backref('driver_owner', lazy=True), foreign_keys=[id_vehicle])


# 6. Station
class Station(db.Model):
    __tablename__ = 'station'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Text, nullable=False)
    latituded = db.Column(db.Float)
    longitude = db.Column(db.Float)
    id_type = db.Column(db.Integer, db.ForeignKey('type.id'))

    db.relationship('Type', backref=db.backref('station', lazy=True))

# 7. GPScoord
class GPScoord(db.Model):
    __tablename__ = 'gpscoord'
    id = db.Column(db.Integer, primary_key=True)
    id_vehicle = db.Column(db.Integer, db.ForeignKey('vehicle.id', ondelete='CASCADE'))
    latituded = db.Column(db.Float)
    longitude = db.Column(db.Float)
    time = db.Column(db.DateTime(timezone=True), server_default=db.func.now())

    vehicle = db.relationship('Vehicle', backref=db.backref('gpscoord', lazy=True))

# 8. events
class Events(db.Model):
    __tablename__ = 'events'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Text, nullable=False)
    location = db.Column(db.Text, nullable=False)
    date_start = db.Column(db.Date, nullable=False)
    date_end = db.Column(db.Date, nullable=False)

# 9. events
class Report(db.Model):
    __tablename__ = 'report'
    id = db.Column(db.Integer, primary_key=True)
    report = db.Column(db.Text, nullable=False)

# 10. parking
class Parking(db.Model):
    __tablename__ = 'parking'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Text, nullable=False)
    latituded = db.Column(db.Float)
    longitude = db.Column(db.Float)
    available_places = db.Column(db.Integer, nullable=False)

# verif login in web app
def verif_login(email, password):
    print(email,password)
    user = AppUser.query.filter_by(email=email).first()
    print(user.password)
    if user and user.password == password:
        return True
    else:
        return False