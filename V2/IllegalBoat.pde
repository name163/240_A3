class IllegalBoat {
    PImage illegal_boat_img;

    int posX;
    int posY;
    int y_speed = (int) random(2, 5);
    int speed;

    // Will add randomiser for enum for boat type later
    BoatType boat_type = BoatType.SMALL;
    
    // Will add randomiser for enum for boat direction later
    BoatDirection boat_direction;

    IllegalBoat(int posY) {
        this.posY = posY;
        this.set_boat_direction();
        switch (boat_direction) {
            // Boat moves towards the left side of screen
            case LEFT:
                switch(boat_type) {
                    case SMALL:
                        illegal_boat_img = loadImage("assets/small_boat_left.png");
                }
                this.speed = int(random(-5, -2));
                this.posX = 720;
                break;

            case RIGHT:
                switch(boat_type) {
                    case SMALL:
                        illegal_boat_img = loadImage("assets/small_boat_right.png");
                }
                this.speed = (int) random(2, 5);
                this.posX = -illegal_boat_img.width;
                break;
        }
    }

    void set_boat_direction() {
        float random_float = random(0, 1);

        if (random_float < 0.5) {
            this.boat_direction = BoatDirection.LEFT;
        }
        else if (random_float >= 0.5) {
            this.boat_direction = BoatDirection.RIGHT;
        }
    }

    // Will implement once the assets are done
    void set_boat_type() {
        float random_float = random(0, 2);
    }

    void increment_y(int y_speed) {
        this.posY += y_speed;
    }

    void draw_boat() {
        this.posX = posX + speed;
        image(illegal_boat_img, posX, posY);
    }

    void boat_disappear() {
        // For V3
    }

    PImage get_image() {
        return illegal_boat_img;
    }

    BoatDirection print_direction() {
        return boat_direction;
    }
}
