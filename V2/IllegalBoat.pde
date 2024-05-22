class IllegalBoat {
    PImage illegal_boat_img;

    int posX;
    int posY;
    int speed;

    // Will add randomiser for enum for boat type later
    BoatType boat_type = BoatType.SMALL;
    
    // Will add randomiser for enum for boat direction later
    BoatDirection boat_direction = BoatDirection.RIGHT;

    IllegalBoat(int posY, int speed) {
        this.posY = posY;
        switch (boat_direction) {
            // Boat moves towards the left side of screen
            case LEFT:
                this.speed = -speed;
                this.posX = -720;

                switch(boat_type) {
                    case SMALL:
                        illegal_boat_img = loadImage("assets/small_boat_left.png");
                }

            case RIGHT:
                this.speed = speed;
                this.posX = 0;

                switch(boat_type) {
                    case SMALL:
                        illegal_boat_img = loadImage("assets/patrol_boat.png");
                }
        }
    }

    void increment_y(int speed) {
        this.posY += speed;
    }

    void draw_boat() {
        this.posX = posX+speed;
        image(illegal_boat_img, posX, posY);
    }

    void boat_disappear() {

    }
}