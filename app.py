from flask import Flask, render_template
import os

app = Flask(__name__)

@app.route('/')
def index():
    images = []

    for f in os.listdir('static/images'):
        if f.endswith('.jpg'):
            images.append('/static/images/' + f) 
            
    return render_template('index.html', images=images)

@app.route('/about')
@app.route('/about.html')
def about():
    return render_template('about.html')

@app.route('/resume')
@app.route('/resume.html')
def resume():
    return render_template('resume.html')

@app.route('/projects')
@app.route('/projects.html')
def projects():
    return render_template('projects.html')

@app.route('/blog')
@app.route('/blog.html')
def blog():  # Renamed this function
    return render_template('blog.html')

@app.route('/contact')
@app.route('/contact.html')
def contact():  # Renamed this function
    return render_template('contact.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)
