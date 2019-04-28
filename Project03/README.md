# Project 3 - Lights Off 

- A simple puzzle game that requires smart thinking

Demo: https://mac1xa3.ca/u/kims171/project3.html

## Step 1: How to Run

1. Set up the Django server first
- on your terminal, type **python3 -m venv django_env**
- then activate the server by **source django_env/bin/activate**
- Install Django and its dependencies by **pip install -r requirements.txt**
2. cd into Project03/django_project directory and run the command: **python3 manage.py runserver localhost:port** where the port is the assigned port number on the server
3. go back to Project03 directory and run **elm make src/Main.elm --output=project3.html**
4. copy this file into the public_html directory
5. The project now should be at https://mac1xa3.ca/u/macid/project3.html where macid is your MAC ID

## Step 2: How to Play

1. Click the **new game** button on the left.
2. The goal of this game is to turn all the lights off, the skyblue squares are the squares you want to change.
3. when you click a square, the color of the 4 squares touching the clicked square will change.
4. Your goal is to turn all the lights off (change all the colors to deep blue) within the goal number of moves.

TIP: If you have played the 2048 game, simliar strategy can be used for this game as well
