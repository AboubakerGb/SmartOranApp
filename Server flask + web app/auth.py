import jwt
import datetime

SECRET_KEY = "123456789"  # tmp key


def generate_token(username):
    payload = {
        "user": username,
        "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=10)  # expire 10hours
    }
    return jwt.encode(payload, SECRET_KEY, algorithm="HS256")

def verify_token(token):
    print(token)
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        return payload["user"]
    except (jwt.ExpiredSignatureError, jwt.InvalidTokenError):
        return None