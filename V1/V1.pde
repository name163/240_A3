// V1: Create moving background

PImage ocean_sparse;
PImage ocean_dense;
PImage ocean_alternate;

float scale_of_objects = 0.5;

int frame_counter = 0;

// Background y coordinates
int background_y = 0;
int sub_background_y;

// The height of the window
int window_height;

void setup() {
    size(720, 1280);

    ocean_sparse = loadImage("assets/ocean_sparse.png");
    ocean_dense = loadImage("assets/ocean_dense.png");
    ocean_alternate = ocean_sparse;

    window_height = height;
    sub_background_y = -window_height;
}

void draw() {
    background(255);
    draw_background();
    frame_counter++;
}

void draw_background() {
    change_background();
    // Added scale for test images
    // scale(1.5);
    image(ocean_alternate, 0, background_y);
    image(ocean_alternate, 0, sub_background_y);

    background_y += 2;
    sub_background_y += 2;
    println(sub_background_y);

    if (background_y >= window_height) {
        println("IN FIRST");
        background_y = -window_height;
    }

    if (sub_background_y >= window_height) {
        println("IN SECOND");
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