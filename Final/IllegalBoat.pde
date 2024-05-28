class IllegalBoat {
    PImage illegal_boat_img;

    int posX;
    int posY;
    int y_speed = (int) random(2, 5);
    int speed;
    int points_worth;

    BoatType boat_type;
    
    BoatDirection boat_direction;

    IllegalBoat(int posY, int speed_mod) {
        this.posY = posY;
        this.set_boat_direction();
        this.set_boat_type();
        switch (boat_direction) {
            // Boat moves towards the left side of screen
            case LEFT:
                switch(boat_type) {
                    case SMALL:
                        illegal_boat_img = loadImage("assets/small_boat_left.png");
                        this.speed = int(random(-4, -3));
                        break;
                    case MEDIUM:
                        illegal_boat_img = loadImage("assets/mid_boat_left.png");
                        this.speed = int(random(-3, -2));
                        break;
                    case LARGE:
                        illegal_boat_img = loadImage("assets/large_boat_left.png");
                        this.speed = int(random(-2, -1));
                        break;
                }
                
                this.posX = 720 + int(random(50, 100));
                this.speed -= speed_mod;
                break;

            // Boat moves towards the right side of screen
            case RIGHT:
                switch(boat_type) {
                    case SMALL:
                        illegal_boat_img = loadImage("assets/small_boat_right.png");
                        this.speed = int(random(3, 4));
                        break;
                    case MEDIUM:
                        illegal_boat_img = loadImage("assets/mid_boat_right.png");
                        this.speed = int(random(2, 3));
                        break;
                    case LARGE:
                        illegal_boat_img = loadImage("assets/large_boat_right.png");
                        this.speed = int(random(1, 2));
                        break;
                }
                
                // Makes the boat spawn more spread out
                // Less of a chance to overlap
                this.posX = -illegal_boat_img.width - int(random(50, 100));
                this.speed += speed_mod;
                break;
        }

        // Resizing PImage of boat because the asset was the wrong size
        float scale = 1.6;
        int img_width_scaled = int(illegal_boat_img.width * scale);
        int img_height_scaled = int(illegal_boat_img.height * scale);
        illegal_boat_img.resize(img_width_scaled, img_height_scaled);
    }

    // Setting boat direction to a random enum
    void set_boat_direction() {
        float random_float = random(0, 1);

        if (random_float < 0.5) {
            this.boat_direction = BoatDirection.LEFT;
        }
        else if (random_float >= 0.5) {
            this.boat_direction = BoatDirection.RIGHT;
        }
    }

    // Setting boat type to a random enum
    void set_boat_type() {
        float random_float = random(0, 2);
        if (random_float < 1.3) {
            this.boat_type = BoatType.SMALL;
            this.points_worth = 1;
        }
        else if (random_float >= 1.3 && random_float < 1.7) {
            this.boat_type = BoatType.MEDIUM;
            this.points_worth = 2;
        }
        else if (random_float >= 1.7) {
            this.boat_type = BoatType.LARGE;
            this.points_worth = 3;
        }
    }

    // Makes boat go down
    void increment_y(int y_speed) {
        this.posY += y_speed;
    }

    void draw_boat() {
        this.posX = posX + speed;
        image(illegal_boat_img, posX, posY);
    }

    // Returns PImage for this object
    PImage get_image() {
        return illegal_boat_img;
    }

    int get_points() {
        return points_worth;
    }
}
