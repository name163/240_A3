// V3: Implement interactions, make boats clickable

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
int img_width_scaled;
int img_height_scaled;

ArrayList<IllegalBoat> illegal_boats = new ArrayList<IllegalBoat>();

void setup() {
    size(720, 1280);

    ocean_sparse = loadImage("assets/ocean_sparse.png");
    ocean_dense = loadImage("assets/ocean_dense.png");
    patrol_boat = loadImage("assets/patrol_boat.png");
    ocean_alternate = ocean_sparse;

    window_height = height;
    sub_background_y = -window_height;

    float scale = 1.6;
    img_width_scaled = int(patrol_boat.width * scale);
    img_height_scaled = int(patrol_boat.height * scale);
}

void draw() {
    background(255);

    draw_background();
    draw_player_boat();

    for (int i = 0; i < illegal_boats.size(); i++) {
        illegal_boats.get(i).draw_boat();
        illegal_boats.get(i).increment_y(scroll_speed);
    }
        
    for (int i = illegal_boats.size()-1; i >= 0; i--) {
        switch(illegal_boats.get(i).boat_direction) {
            case LEFT:
                delete_left(i);
            case RIGHT:
                delete_right(i);
        }
    }

    if (illegal_boats.size() < random(1, 5)) {
        spawn_illegal_boat();
    }

    frame_counter++;
}

void delete_left(int i) {
    try {
        if (illegal_boats.get(i).posY >= height) {
            illegal_boats.remove(i);
        }
        if (illegal_boats.get(i).posX <= 0-illegal_boats.get(i).get_image().width) {
            illegal_boats.remove(i);
        }
    } catch (Exception e) {}
    
}

void delete_right(int i) {
    try {
        if (illegal_boats.get(i).posY >= height) {
            illegal_boats.remove(i);
        }
        if (illegal_boats.get(i).posX >= width) {
            illegal_boats.remove(i);
        }
    } catch (Exception e) {}
}

void draw_background() {
    change_background();

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
    
    patrol_boat.resize(img_width_scaled, img_height_scaled);
    image(patrol_boat, 360, 1000);
    imageMode(CORNER);
}

void spawn_illegal_boat() {
    int posY = (int) random(0, 300);
    IllegalBoat newBoat = new IllegalBoat(posY);
    illegal_boats.add(newBoat);
}

// Fixed using mousePressed()
void mousePressed() {
    for (int i = illegal_boats.size()-1; i >= 0; i--) {
    // for (int i = 0; i < illegal_boats.size(); i--) {
        IllegalBoat boat = illegal_boats.get(i);
        println(boat);
        if (mouseX > boat.posX && mouseX < boat.posX + boat.get_image().width) {
            if (mouseY > boat.posY && mouseY < boat.posY + boat.get_image().height) {
                illegal_boats.remove(i);
                break;
            }
        }
    }
}
