from flask import Flask, render_template
import os

app = Flask(__name__)

@app.route('/')
def index():
    images = []
    
    for f in os.listdir('static/images'):
        if f.endswith('.jpg'):
            images.append('/static/images/' + f) # use append instead of +=
            
    return render_template('index.html', images=images)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)

