import java.util.Random;

Ball b;
final int INTRO = 0;
final int GAME = 1;

int state = INTRO;

int gameSpeed = 5; // Default game speed
int numBalls = 1; // Default number of balls
int finishScore = 20; // Default finish score

// Input fields
String speedInput = "5";
String ballsInput = "1";
String scoreInput = "20";

// Track which input field is active
int activeInputField = 0; // 0 = none, 1 = speed, 2 = balls, 3 = score

void setup() {

    b = new Ball();

    size(1200, 900);
    noFill();
    translate(width / 2, height / 2);

    textAlign(CENTER);
    textSize(16);
    strokeWeight(2);
}

static class AngleGenerator {

    public static Random random = new Random(System.currentTimeMillis());

    public static float nextAngle() {
        return random.nextFloat() * TWO_PI;
    }
}

class Ball {
    private float angle = 0;

    public float rotationSpeed = 0.19;
    public float t = 0.0;

    public int color1 = -1;
    public int color2 = 0;

    public float x = width / 2;
    public float y = height / 2;

    public float r = 100;

    public float moveAngle;

    public Ball() {
        moveAngle = AngleGenerator.nextAngle();
        t = AngleGenerator.random.nextFloat();
        while ((PI / 2 - 0.2 < moveAngle && moveAngle < PI / 2 + 0.2)
                || (PI / 2 - 0.2 < -moveAngle && -moveAngle < PI / 2 + 0.2) ||
                (PI - 0.2 < moveAngle && moveAngle < PI + 0.2) || (PI - 0.2 < -moveAngle && -moveAngle < PI + 0.2)) {
            moveAngle = AngleGenerator.nextAngle();
        }
    }

    void roll() {
        angle += rotationSpeed * t;
    }

    void draw() {
        translate(x, y);
        rotate(angle);

        strokeWeight(1);
        fill(color1);
        ellipse(0, 0, 2 * r, 2 * r);

        noStroke();
        beginShape();
        fill(color2);
        vertex(0, 0);
        bezierVertex(-0.75 * r, 0, -0.75 * r, r, 0, r);
        arc(0, 0, 2 * r, 2 * r, -PI / 2, PI / 2, CHORD);
        ellipse(0, 0.5 * r, r, r);
        endShape();

        beginShape();
        fill(color1);
        vertex(0, -r);
        bezierVertex(0.75 * r, -r, 0.75 * r, 0, 0, 0);
        ellipse(0, -0.5 * r, r, r);
        endShape();

        stroke(color2);
        noFill();
        ellipse(0, 0, 2 * r, 2 * r);

        fill(color2);
        ellipse(0, -0.5 * r, 0.25 * r, 0.25 * r);

        fill(color1);
        ellipse(0, 0.5 * r, 0.25 * r, 0.25 * r);
    }
}

void drawSun(float a) {
    translate(width / 2, height / 2);
    rotate(a);

    float x = 0;
    float y = 350;
    float radius = 80;
    // Рисуем солнце(круг)
    fill(255, 204, 0); // Желтыйцвет
    noStroke();
    circle(x, y, radius * 2);

    // Рисуем лучи
    float rayLength = radius * 1.5; // Длина лучей
    for (int i = 0; i < 12; i++) {
        float angle = TWO_PI / 12 * i; // Угол для каждого луча
        float x1 = x + cos(angle + PI / 2) * radius * 0.7; // Конец круга
        float y1 = y + sin(angle + PI / 1) * radius * 0.7;
        float x2 = x + cos(angle - PI / 2) * radius * 0.7; // Конец круга
        float y2 = y + sin(angle - PI / 2) * radius * 0.7;
        float x3 = x + cos(angle) * rayLength; // Конец луча
        float y3 = y + sin(angle) * rayLength;

        // print("; triangle: ", x3, y3, x1, y1, x2, y2);
        triangle(x3, y3, x1, y1, x2, y2); // Рисуем треугольник для луча
    }

}

void drawSlider(float t) {

    translate(40, height - 45);
    textSize(12);

    int barLength = width - 2 * 40;

    strokeWeight(4);
    stroke(122);
    noFill();
    line(0, 0, 40, 0);
    line(barLength, -5, barLength, 5);

    stroke(122);
    noFill();
    line(0, -5, 0, 5);
    line(0, 0, t * barLength, 0);

    noStroke();
    fill(122);
    text(nf(t * 100, 0, 2), barLength / 2, 25);

}

void drawMountains() {
    noStroke(); // Убираем контур у треугольников

    // Первая гора
    fill(139, 69, 19); // Цвет первой горы (коричневый)
    triangle(-100, 500, 150, 200, 600, 500);
    rect(0, 500, 600, 700);

    // Вторая гора
    fill(160, 82, 45); // Цвет второй горы (темно-коричневый)
    triangle(500, 500, 700, 150, 1000, 500);
    rect(500, 500, 400, 700);

    // Третья гора
    fill(205, 133, 63); // Цвет третьей горы (светло-коричневый)
    triangle(900, 500, 1100, 100, 1300, 500);
    rect(900, 500, 400, 700);

}

void drawMoon(float a) {
    translate(width / 2, height / 2);
    rotate(a);

    float x = 0;
    float y = -350;
    float radius = 80;

    noFill(); // Убираем заливку

    // Заливка между двумя кривыми

    beginShape();

    fill(255, 255, 0);
    curveVertex(x - radius * 6, y - radius);

    curveVertex(x, y - radius);
    curveVertex(x, y + radius);

    curveVertex(x - radius * 6, y + radius);

    endShape();

    beginShape();
    fill(b.color2);
    curveVertex(x - radius * 3, y - radius);
    curveVertex(x, y - radius);
    curveVertex(x, y + radius);
    curveVertex(x - radius * 3, y + radius);

    endShape();

    strokeWeight(2);
    stroke(b.color2);
    line(0, 0, 0, -444);

}

void drawSky(float a) {
    translate(width / 2, height / 2);
    rotate(a);

    color nightColor = color(0, 0, 0); // fullnight
    color dayColor = color(135, 206, 250); // Bright blue (sky blue)

    // display gradient
    int n = 200;

    float a1 = PI * 3 / 2, a2 = PI * 3 / 2;
    float b1 = PI * 3 / 2, b2 = PI * 3 / 2;

    float segmentWithoutGradient = PI / 12;

    fill(nightColor);
    stroke(nightColor);
    arc(0, 0, 1555, 1555, a1 - segmentWithoutGradient / 2,
            a1 + segmentWithoutGradient / 2);

    fill(dayColor);
    stroke(dayColor);
    arc(0, 0, 1555, 1555, a1 + PI - segmentWithoutGradient / 2,
            a1 + PI + segmentWithoutGradient / 2);

    a1 += segmentWithoutGradient / 2;
    b1 -= segmentWithoutGradient / 2;
    for (int i = 0; i < n; i++) {
        float inter = map(i, 0, n, 0, 1);
        a1 = a2;
        a2 += (PI - segmentWithoutGradient / 2) / n;
        b1 = b2;
        b2 -= (PI - segmentWithoutGradient / 2) / n;

        color gradientColor = lerpColor(nightColor, dayColor, inter);

        fill(gradientColor);
        stroke(gradientColor);
        arc(0, 0, 1555, 1555, a1, a2 + (a2 - a1) / 5);
        arc(0, 0, 1555, 1555, b2, b1 + (a2 - a1) / 5);
    }
}

void drawButton(String label, float x, float y, float w, float h) {
    // Draw button text
    fill(255, 215, 0); // Golden text
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h / 2);

    // Draw button border(optional)
    noFill();
    stroke(255, 215, 0);
    rect(x, y, w, h);
}

void drawInputField(String label, float x, float y, float w, float h, boolean active) {

    // Draw input field background
    fill(active ? 200 : 100); // Highlight if active
    rect(x, y, w, h);

    textAlign(LEFT, CENTER);

    // Draw label
    fill(255, 215, 0); // Golden text
    text(label, x, y - 40);
}

void drawOptionsTab() {
    translate(0, 300);
    textSize(66);

    // Draw a simple options tab at the top of the screen
    fill(50); // Dark background for the tab
    noStroke();
    rect(0, 0, width, 600); // Adjust height as needed

    // Draw input fields and labels
    drawInputField("Game Speed", width / 2 - 300, 100, 600, 100, activeInputField == 1);
    drawInputField("Number of Balls", width / 2 - 300, 300, 600, 100, activeInputField == 2);
    drawInputField("Finish Score", width / 2 - 300, 500, 600, 100, activeInputField == 3);

    // Display current values
    fill(255, 215, 0); // Golden text
    textAlign(LEFT, CENTER);
    text(speedInput, width / 2 - 300, 150);
    text(ballsInput, width / 2 - 300, 350);
    text(scoreInput, width / 2 - 300, 550);
    
    textSize(33);
    drawButton("To main menu\n(or press enter)", 0, 433, 266, 166);
}

boolean isMouseOverButton(float x, float y, float w, float h) {
    // Check if the mouse is within the button's bounds
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
}

boolean showOptions = false;

void drawBackground() {
  pushMatrix();
    drawSky(b.angle);
    popMatrix();

    pushMatrix();
    drawSun(b.angle);
    popMatrix();

    pushMatrix();
    drawMoon(b.angle);
    popMatrix();
}

void drawIntro() {

    drawBackground();


    if (mousePressed && !showOptions) {

        if (mouseY >= height - 100) {
            int a = constrain(mouseX, 40, width - 40);
            b.t = map(a, 40, width - 40, 0.0, 1.0);
        }

        else if (mouseY <= height * 4 / 6 - 11) {

            int y = min(mouseY, (int)(height * 4 / 6 - b.r));
            y = max(y, 200);
            b.y = y;
        }
    }

    pushMatrix();
    drawMountains();
    popMatrix();

    pushMatrix();
    drawSlider(b.t);
    popMatrix();

    pushMatrix();
    b.draw();
    popMatrix();

    textSize(66);
    // Draw "Start Game" button
    drawButton("Start Game", width / 2 - 200, height * 4 / 6, 400, 88);

    // Draw "Options" button
    drawButton("Options", width / 2 - 200, height * 5 / 6, 400, 88);

    // Display options tab if showOptions is true
    if (showOptions) {
        drawOptionsTab();
    }

}

void drawField() {
  translate(0, 100);

  for (int x = 0; x < width; x++) {
    // Calculate the grayscale value based on the x position
    float grayValue = map(x, 0, width, 0, 255);
    stroke(grayValue); // Set the stroke color
    line(x, 0, x, height); // Draw a vertical line
  }
}

void drawGame() {


  pushMatrix();
  drawField();
  popMatrix();

  
}

void draw() {
    switch (state) {
        case INTRO:
            drawIntro();
            break;
        case GAME:
            drawGame();
            break;
    }

    
    b.roll();
}

void mousePressed() {
    print(showOptions);
    if (showOptions) {
        if (isMouseOverButton(width / 2 - 300, 400, 600, 100)) {
            activeInputField = 1; // Activate game speed input
        } else if (isMouseOverButton(width / 2 - 300, 600, 600, 100)) {
            activeInputField = 2; // Activate number of balls input
        } else if (isMouseOverButton(width / 2 - 300, 800, 600, 100)) {
            activeInputField = 3; // Activate finish score input
        } else {
            activeInputField = 0; // Deactivate all inputs
        }

        if(isMouseOverButton(0, 733, 266, 166)) {
          showOptions = false;
        }
    }

    else {
        switch (state) {
            case INTRO:
                if (isMouseOverButton(width / 2 - 200, height * 4 / 6, 400, 88)) {
                    state = GAME;
                }

                // Check if "Options" button is clicked
                else if (isMouseOverButton(width / 2 - 200, height * 5 / 6, 400, 88)) {
                    showOptions = true;
                }
                break;
        }
    }
}

void keyReleased() {
    if (state == INTRO) {
        if (key == CODED) {
            if (keyCode == LEFT) {
                b.t = max(0, b.t - 0.1);
            }
            if (keyCode == RIGHT) {
                b.t = min(1, b.t + 0.1);
            }
            if (keyCode == UP) {
                b.y = max(b.r, b.y - 55);
            }
            if (keyCode == DOWN) {
                b.y = min(height - b.r, b.y + 55);
            }
            if (keyCode == ALT) {
                b.r = max(1, b.r - 55);
            }
            if (keyCode == SHIFT) {
                b.r = min(300, b.r + 55);
            }
        }
    }

    if (showOptions) {
        print(key, activeInputField);
        if (activeInputField != 0) {
            if (key == BACKSPACE) {
                // Handle backspace
                switch (activeInputField) {
                    case 1:
                        if (speedInput.length() > 0) {
                            speedInput = speedInput.substring(0, speedInput.length() - 1);
                        }
                        break;
                    case 2:
                        if (ballsInput.length() > 0) {
                            ballsInput = ballsInput.substring(0, ballsInput.length() - 1);
                        }
                        break;
                    case 3:
                        if (scoreInput.length() > 0) {
                            scoreInput = scoreInput.substring(0, scoreInput.length() - 1);
                        }
                        break;
                }
                
            } else if (key >= '0' && key <= '9') {
                // Handle numeric input
                switch (activeInputField) {
                    case 1:
                        speedInput += key;
                        break;
                    case 2:
                        ballsInput += key;
                        break;
                    case 3:
                        scoreInput += key;
                        break;
                }
                } else if (key == ENTER || key == RETURN) {
            switch (activeInputField) {
                    case 1:
                        try {
                            gameSpeed = Integer.parseInt(speedInput);
                        } catch (NumberFormatException e) {
                            gameSpeed = 5; // Reset to default if input is invalid
                            speedInput = "5";
                        }
                        break;
                    case 2:
                        try {
                            numBalls = Integer.parseInt(ballsInput);
                        } catch (NumberFormatException e) {
                            numBalls = 1; // Reset to default if input is invalid
                            ballsInput = "1";
                        }
                        break;
                    case 3:
                        try {
                            finishScore = Integer.parseInt(scoreInput);
                        } catch (NumberFormatException e) {
                            finishScore = 20; // Reset to default if input is invalid
                            scoreInput = "20";
                        }
                        break;
                }
                activeInputField = 0;
        }
    }
    else {
      if(key == ENTER || key == RETURN || key == ESC) {
        showOptions = false;
      }
    }
}
}
