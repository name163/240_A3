// Final: Code refactoring, implementing game over screen

PImage ocean_sparse;
PImage ocean_dense;
PImage ocean_alternate;
PImage patrol_boat;

PFont my_font;

float scale_of_objects = 0.5;
float text_angle = 200;
float health_bar_scale = 0.2;

int frame_counter = 0;
int scroll_speed = 2;   // Speed of background
int background_y = 0;   // Background y coordinates
int sub_background_y;   // y coordinate for second background
int window_height;
int img_width_scaled;
int img_height_scaled;
int health_width_scaled;
int health_height_scaled;
int player_score;
int difficulty_modifier = 1;    // Difficulty starts at 1
int player_health = 3;  // Player total health
int top_score = 0;

boolean game_started = false;
boolean game_over = false;

ArrayList<IllegalBoat> illegal_boats = new ArrayList<IllegalBoat>();

PImage[] health_bar = new PImage[player_health];    // Length of health bar is based on total health

void setup() {
    size(720, 1280);
    noStroke();

    // Loading background
    ocean_sparse = loadImage("assets/ocean_sparse.png");
    ocean_dense = loadImage("assets/ocean_dense.png");
    patrol_boat = loadImage("assets/patrol_boat.png");

    ocean_alternate = ocean_sparse;

    // Initialising text options
    my_font = createFont("Minecraft Regular", 30);
    textFont(my_font);
    textAlign(CENTER, CENTER);

    // Setting position of where background image loads
    window_height = height;
    sub_background_y = -window_height;

    // Rescaling patrol boat
    float patrol_boat_scale = 1.6;
    img_width_scaled = int(patrol_boat.width * patrol_boat_scale);
    img_height_scaled = int(patrol_boat.height * patrol_boat_scale);
}

void draw() {
    background(255);
    draw_background();
    draw_player_boat();

    // Check if the game has started
    // If game has started, remove start text and spawn in IllegalBoat objects
    if (!game_started) {
        display_start_text();
    } else if (game_over) {
        display_end_text();
    }
    else {
        display_player_score();
        update_difficulty_modifier();
        display_life();
        check_player_health();

        // Added try / catch to prevent errors when i > illegal_boats.size()
        try {
            // Iterates through list of boats to move them
            for (int i = 0; i < illegal_boats.size(); i++) {
                illegal_boats.get(i).draw_boat();
                illegal_boats.get(i).increment_y(scroll_speed);
            }
            
            // Checks every IllegalBoat object in the list to see if they're off screen
            // If they are, remove them from the list by calling respective functions
            for (int i = illegal_boats.size()-1; i >= 0; i--) {
                switch(illegal_boats.get(i).boat_direction) {
                    case LEFT:
                        delete_left(i);
                    case RIGHT:
                        delete_right(i);
                }
            }
        } catch (Exception e) {}
        
        // Spawns in boats based on difficulty modifier
        if (illegal_boats.size() < 1 + difficulty_modifier) {
            spawn_illegal_boat();
        }
    }

    frame_counter++;
}

void display_start_text() {
    fill(0, 100);
    rect(0, 0, width, height);
    fill(255);
    // 2 * sin(text_angle) + height makes the text go up and down in a sine wave
    text(
        "Around 21% of global fish catch\ncomes from overfishing.\n\nStop as many illegal fishing boats\nas you can!",
        width/2, 2 * sin(text_angle) + (height/3));
    text("Click to play", width/2, 2 * sin(text_angle) + (2*height/3));
    text("Top score: " + top_score, width/2, 2 * sin(text_angle) + (1.5*height/3));
    text_angle -= 0.1;
}

void display_end_text() {
    fill(0, 100);
    rect(0, 0, width, height);
    fill(255);
    // 2 * sin(text_angle) + height makes the text go up and down in a sine wave
    text(
        "Overfishing\nhas destroyed aquatic life :(\n\nTo report potential\nillegal fishing activity:\ncall 0800 47 62 24.",
        width/2, 2 * sin(text_angle) + (height/3));
    text("Click to return to main menu", width/2, 2 * sin(text_angle) + (2*height/3));
    text("Final score: " + player_score, width/2, 2 * sin(text_angle) + (1.5*height/3));
    text_angle -= 0.1;
}

void display_player_score() {
    fill(0, 100);
    rect(260, 0, 200, 60);
    fill(255);
    text("Score: " + player_score, width/2, 25);
}

void display_life() {
    for (int i = 0; i < health_bar.length; i++) {
        if (i < player_health) {
            health_bar[i] = loadImage("assets/health_alive.png");
            resize_health(i);
        }
        else {
            health_bar[i] = loadImage("assets/health_dead.png");
            resize_health(i);
        }
    }
}

// Because the assets given to me was in a different size
// I created this method to scale the image down
void resize_health(int i) {
    health_width_scaled = int(health_bar[i].width * health_bar_scale);
    health_height_scaled = int(health_bar[i].height * health_bar_scale);
    health_bar[i].resize(health_width_scaled, health_height_scaled);
    image(health_bar[i], 100 + (health_bar[i].width * i), 5);
}

void delete_left(int i) {
    // Checks if boat moves off the screen
    // Added try / catch to prevent errors when removing from the list
    try {
        if (illegal_boats.get(i).boat_direction == BoatDirection.LEFT) {
            if (illegal_boats.get(i).posY >= height) {
                illegal_boats.remove(i);
                player_health -= 1;
            }
            if (illegal_boats.get(i).posX <= 0 - illegal_boats.get(i).get_image().width) {
                illegal_boats.remove(i);
                player_health -= 1;
            }
        }
    } catch (Exception e) {}
    
}

void delete_right(int i) {
    // Checks if boat moves off the screen
    // Added try / catch to prevent errors when removing from the list
    try {
        if (illegal_boats.get(i).boat_direction == BoatDirection.RIGHT) {
            if (illegal_boats.get(i).posY >= height) {
                illegal_boats.remove(i);
                player_health -= 1;
            }
            if (illegal_boats.get(i).posX >= width) {
                illegal_boats.remove(i);
                player_health -= 1;
            }
        }
    } catch (Exception e) {}
}

void draw_background() {
    change_background();

    image(ocean_alternate, 0, background_y);
    image(ocean_alternate, 0, sub_background_y);

    background_y += scroll_speed;
    sub_background_y += scroll_speed;

    // Resets background y position to above the screen
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

void draw_player_boat() {
    imageMode(CENTER);
    patrol_boat.resize(img_width_scaled, img_height_scaled);
    image(patrol_boat, 360, 1000);
    imageMode(CORNER);
}

void spawn_illegal_boat() {
    int posY = (int) random(0, 300);
    IllegalBoat newBoat = new IllegalBoat(posY, difficulty_modifier);
    illegal_boats.add(newBoat);
}

void update_difficulty_modifier() {
    // Every 10 seconds the difficulty increase
    if (frame_counter % 600 == 0) {
        difficulty_modifier += 1;
    }
}

void check_player_health() {
    if (player_health <= 0) {
        game_over = true;
    }
}

void reset_game() {
    game_started = false;
    player_health = 3;
    if (player_score > top_score) {
        top_score = player_score;
    }
    player_score = 0;
    difficulty_modifier = 1;
    illegal_boats = new ArrayList<IllegalBoat>();
}

void mousePressed() {
    // When player clicks the first time
    if (!game_started) {
        game_started = true;
    } else if (game_over) {
        reset_game();
        game_over = false;
    }

    for (int i = illegal_boats.size()-1; i >= 0; i--) {
        IllegalBoat boat = illegal_boats.get(i);
        // Checks mouse coords with coords of IllegalBoat object
        if (mouseX > boat.posX && mouseX < boat.posX + boat.get_image().width) {
            if (mouseY > boat.posY && mouseY < boat.posY + boat.get_image().height) {
                player_score += boat.get_points();
                illegal_boats.remove(i);
                break;
            }
        }
    }
}
