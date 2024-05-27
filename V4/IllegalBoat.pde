class IllegalBoat {
    PImage illegal_boat_img;
    PImage dead_boat_arrow;

    int posX;
    int posY;
    int y_speed = (int) random(2, 5);
    int speed;
    int points_worth;

    float opacity = 255;

    boolean boat_img_disappear = false;

    BoatType boat_type;
    
    BoatDirection boat_direction;

    IllegalBoat(int posY) {
        this.posY = posY;
        this.set_boat_direction();
        this.set_boat_type();
        switch (boat_direction) {
            // Boat moves towards the left side of screen
            case LEFT:
                switch(boat_type) {
                    case SMALL:
                        illegal_boat_img = loadImage("assets/small_boat_left.png");
                        this.speed = int(random(-2, -1));
                        break;
                    case MEDIUM:
                        illegal_boat_img = loadImage("assets/mid_boat_left.png");
                        this.speed = int(random(-3, -2));
                        break;
                    case LARGE:
                        illegal_boat_img = loadImage("assets/large_boat_left.png");
                        this.speed = int(random(-5, -3));
                        break;
                }
                
                this.posX = 720 + int(random(50, 100));
                break;

            case RIGHT:
                switch(boat_type) {
                    case SMALL:
                        illegal_boat_img = loadImage("assets/small_boat_right.png");
                        this.speed = int(random(1, 2));
                        break;
                    case MEDIUM:
                        illegal_boat_img = loadImage("assets/mid_boat_right.png");
                        this.speed = int(random(2, 3));
                        break;
                    case LARGE:
                        illegal_boat_img = loadImage("assets/large_boat_right.png");
                        this.speed = int(random(3, 5));
                        break;
                }
                
                this.posX = -illegal_boat_img.width - int(random(50, 100));
                break;
        }

        float scale = 1.6;
        int img_width_scaled = int(illegal_boat_img.width * scale);
        int img_height_scaled = int(illegal_boat_img.height * scale);
        illegal_boat_img.resize(img_width_scaled, img_height_scaled);
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
        if (random_float < 0.8) {
            this.boat_type = BoatType.SMALL;
            this.points_worth = 1;
        }
        else if (random_float >= 0.8 && random_float < 1.5) {
            this.boat_type = BoatType.MEDIUM;
            this.points_worth = 2;
        }
        else if (random_float >= 1.5) {
            this.boat_type = BoatType.LARGE;
            this.points_worth = 3;
        }
    }

    void increment_y(int y_speed) {
        this.posY += y_speed;
    }

    void draw_boat() {
        this.posX = posX + speed;
        if (boat_img_disappear) {
            tint(255, this.opacity);
            boat_disappear();
            image(illegal_boat_img, posX, posY);
            tint(255, 255);
        } else {
            image(illegal_boat_img, posX, posY);
        }
        if (this.opacity == 0) {
            illegal_boats.remove(this);
        }
    }

    void boat_disappear() {
        // half a second time to disappear
        this.opacity -= 8.5;
        if (this.opacity < 0) {
            this.opacity = 0;
        }
    }

    PImage get_image() {
        return illegal_boat_img;
    }

    BoatDirection print_direction() {
        return boat_direction;
    }

    int get_points() {
        return points_worth;
    }

    void remove_from_list() {
        boat_img_disappear = true;
    }
}
