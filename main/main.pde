import processing.video.*;

Pagemanager pages;

void setup() {
  fullScreen(); // Sets the program to run in fullscreen

  imageMode(CENTER); // Sets the image mode to be in center, as it felt the best to use.

  importFiles(); // The program runs the importFiles function which, as the name states, imports the files.

  // The program instantiates the different dilemmas
  pages.bottle = pages.instantiate(0, "SIDES");
  pages.transport = pages.instantiate(1, "SIDES");
  pages.food = pages.instantiate(2, "MIDDLE");
  pages.shopping = pages.instantiate(3, "MIDDLE");
  pages.gaming = pages.instantiate(4, "SIDES");
  pages.work = pages.instantiate(5, "SIDES");
}

void draw() {
  background(0); // Just to make sure there is not an after image from a previous frame, the program draws a background color.

  pages.pageController(); // Then following that, the program runs the pageController function from PageManager class, created at line 3 and initialized in the importFiles() function.


  // --- FOR DEV PURPOSES --- //
  String fps = nf(frameRate, 0, -1);
  fill(0, 255, 0);
  textAlign(LEFT);
  text(fps, width-50, 50);
  // --- FOR DEV PURPOSES --- //
}

// In this function, the program imports all the relevant files into the program, which then gets used when initializing the PageManager class.
void importFiles() {
  // For the background images, the program loads a lot of images and saves them in an array.
  PImage[] backgroundImages = new PImage[]{loadImage("scene1-concept1.png"), loadImage("dilemma01_sketch00.png"), loadImage("kitchenmadfri.jpg"), loadImage("dilemma04_shoppingDraft00.png"), loadImage("bedroom.png"), loadImage("factory2.png")};

  // For importing the movies, it is split into two different variables. 
  String[] movieNames = {"OAanimation.mov", "midlertidig.mp4", "OAanimation.mov", "OAanimation.mov", "OAanimation.mov", "OAanimation.mov"}; // The first is the list of movieNames
  Movie[] listOfMovies = new Movie[movieNames.length]; // Which gets used to determine the length of of the Movie array

  // Then the program imports the movie names importing each individual file that gets listed in movieNames.
  for (int i = 0; i < movieNames.length; i++)
  {
    listOfMovies[i] = new Movie(this, movieNames[i]); // Then that movie file gets added to the movie array
    listOfMovies[i].pause(); // The program then pauses that video file, as the program does not want them all to play at the same time.
  }

  // The program initializes an ArrayList for the sprites. The program handles it in ArrayList, so it can loop through a PImage array, instead of having every PImage.
  ArrayList<PImage[]> sprites = new ArrayList<PImage[]>();
  
  // For an object, it loads the images needed, resizes them and then adds that PImage array to the sprite ArrayList.
  PImage[] bottleObject = new PImage[]{loadImage("waterBottle2.1.png"), loadImage("waterBottle2.2.png")};
  // For resizing, the program has a for loop that goes through for every element in the above array.
  for (int i = 0; i < bottleObject.length; i++) {
    bottleObject[i].resize(bottleObject[i].width/5, bottleObject[i].height/5); // Then it takes that image dimensions and scales it down.
  }
  sprites.add(bottleObject); // Following that the program adds that array to the arrayList

  // ~~~ Same as above ~~~ //
  PImage[] keys = new PImage[]{loadImage("keyChain01.png"), loadImage("keyChainHighlight01.png")};
  for (int i = 0; i < keys.length; i++) {
    keys[i].resize(keys[i].width/5, keys[i].height/5);
  }
  sprites.add(keys);

  // ~~~ Same as above ~~~ //
  PImage[] food = new PImage[]{loadImage("beef2.1.png"), loadImage("beef2.2.png"), loadImage("carrot2.1.png"), loadImage("carrot2.2.png")};
  for (int i = 0; i < food.length; i++) {
    food[i].resize(food[i].width/5, food[i].height/5);
  }
  sprites.add(food);
  
  // ~~~ Same as above ~~~ //
  PImage[] shopItem = new PImage[]{loadImage("shopItem00.png"), loadImage("shopItem00.png"), loadImage("shopItem01.png"), loadImage("shopItem01.png")};
  for (int i = 0; i < shopItem.length; i++) {
    shopItem[i].resize(shopItem[i].width/5, shopItem[i].height/5);
  }
  sprites.add(shopItem); 
  
  // ~~~ Same as above ~~~ //
  PImage[] hand = new PImage[]{loadImage("hand.png"), loadImage("handglow.png")};
  for (int i = 0; i < hand.length; i++) {
    hand[i].resize(hand[i].width/5, hand[i].height/5);
  }
  sprites.add(hand);
  sprites.add(hand);

  // Then the program initializes the PageManager with the arrays and arrayList
  pages = new Pagemanager(listOfMovies, backgroundImages, sprites);
  println(millis()); // For debugging we see how long it takes in milliseconds
}

// As an event, mousePressed, the program calls the function "checkIfInteract()" for checking if the user clicks on an object
void mousePressed() {
  pages.checkIfInteract();
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}
