from flask import Flask, render_template, request

app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        # Handle form submission here if needed
        skill = request.form.get('skill')
        experience = request.form.get('experience')
        location = request.form.get('location')
        designation = request.form.get('designation')
        # Add your logic or processing steps here

    return render_template('index.html')


if __name__ == '__main__':
    app.run(debug=True)
