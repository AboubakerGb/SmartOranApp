# BIG NOTE FOR THE SERVER APP
API Base URL: `http://192.168.238.115:5000` (from Flask backend)
To run the app:
cd SmartOranApp "(project name)"
npm install  
npx expo start

# create and activate your virtualenv for backend :
python3 -m venv venv && source venv/bin/activate  
pip install -r requirements.txt  
flask run  

# access the app folder, install dependencies then run frontend :
cd SmartOranApp "(project name)"
npm install  
npx expo start

Libraries Used
- react-native
- @react-navigation/native + stack
- axios
- react-native-screens
- react-native-safe-area-context
- react-native-reanimated
- expo-font 
- expo-location
- expo-splash-screen
- expo-status-bar

# Web framework
Flask>=2.0,<3.0                    # Flask 2.x series                                      

# ORM / Database
Flask-SQLAlchemy>=3.0              # SQLAlchemy integration for Flask                      
SQLAlchemy>=1.4                    # Core SQLAlchemy ORM                                   
PyMySQL>=1.0                        # MySQL driver                                          

# Authentication
Flask-JWT-Extended>=4.0            # JWT support for Flask                                 

# (optional tooling)
python-dotenv>=1.0                 # load .env config
