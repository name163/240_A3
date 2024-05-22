// V2: Create illegal_boat class

PImage ocean_sparse;
PImage ocean_dense;
PImage ocean_alternate;
PImage patrol_boat;

float scale_of_objects = 0.5;

int frame_counter = 0;
int scroll_speed = 2;
// Background y coordinates
int background_y = 0;
int sub_background_y;
// The height of the window
int window_height;

ArrayList<IllegalBoat> illegal_boats = new ArrayList<IllegalBoat>();

void setup() {
    size(720, 1280);

    ocean_sparse = loadImage("assets/ocean_sparse.png");
    ocean_dense = loadImage("assets/ocean_dense.png");
    patrol_boat = loadImage("assets/patrol_boat.png");
    ocean_alternate = ocean_sparse;

    window_height = height;
    sub_background_y = -window_height;

    // Spawn in some patrol boats
    spawn_illegal_boat();
}

void draw() {
    background(255);
    draw_background();
    draw_player_boat();

    for (int i = illegal_boats.size()-1; i >= 0; i--) {
        illegal_boats.get(i).draw_boat();
        illegal_boats.get(i).increment_y(scroll_speed);
        if (illegal_boats.get(i).posY >= height) {
            illegal_boats.remove(i);
        }
        if (illegal_boats.get(i).posX >= width) {
            illegal_boats.remove(i);
        }
    }
    if (illegal_boats.size() < 10) {
        spawn_illegal_boat();
    }

    frame_counter++;
}

void draw_background() {
    change_background();
    // Added scale for test images
    // scale(1.5);
    image(ocean_alternate, 0, background_y);
    image(ocean_alternate, 0, sub_background_y);

    background_y += scroll_speed;
    sub_background_y += scroll_speed;

    if (background_y >= window_height) {
        background_y = -window_height;
    }

    if (sub_background_y >= window_height) {
        sub_background_y = -window_height;
    }
}

// Changing background every 30 frames (half a second)
void change_background() {
    if (frame_counter%60==30) {
        ocean_alternate = ocean_dense;
    }
    else if (frame_counter%60==0) {
        ocean_alternate = ocean_sparse;
    }
}

void reset_background() {
    background_y = 0;
    sub_background_y = -window_height;
}

void draw_player_boat() {
    imageMode(CENTER);
    image(patrol_boat, 360, 1000);
    imageMode(CORNER);
}

void spawn_illegal_boat() {
    int posY = (int) random(0, 300);
    int speed = (int) random(2, 5);
    IllegalBoat newBoat = new IllegalBoat(posY, speed);
    illegal_boats.add(newBoat);
}

