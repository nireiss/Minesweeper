
import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 10;
private final static int NUM_COLS = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton [NUM_ROWS][NUM_COLS];
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int j = 0; j < NUM_COLS; j++ ) {
      buttons [i][j] = new MSButton(i, j);
    }
  }

  setMines();
}
public void setMines()
{
  // while(mines.size() < NUM_BOMBS
  for (int i = 0; i < 10; i++) {
    int r = (int)(Math.random() * NUM_ROWS);
    int c = (int)(Math.random() * NUM_COLS);
    mines.add(buttons[r][c]);
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  int counter = 0;
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if (buttons[r][c].clicked == true)
        counter++;
    }
  }
  if (counter == 90)
    return true;
  return false;
}
public void displayWinningMessage()
{
  buttons[0][0].setLabel("V");
  buttons[0][1].setLabel("I");
  buttons[0][2].setLabel("C");
  buttons[0][3].setLabel("T");
  buttons[0][4].setLabel("O");
  buttons[0][5].setLabel("R");
  buttons[0][6].setLabel("Y");
  buttons[0][7].setLabel("!");
}
public void displayLosingMessage()
{
  buttons[0][0].setLabel("F");
  buttons[0][1].setLabel("A");
  buttons[0][2].setLabel("I");
  buttons[0][3].setLabel("L");
  buttons[0][4].setLabel("!");
}
public boolean isValid(int r, int c)
{
  if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
    return true;
  return false;
}
public int countMines(int row, int col)
{
  int ans = 0;
  if (isValid(row-1, col-1) == true)
    if (mines.contains(buttons[row-1][col-1]))
      ans ++;
  if (isValid(row-1, col) == true)
    if (mines.contains(buttons[row-1][col]))
      ans ++;
  if (isValid(row-1, col+1) == true)
    if (mines.contains(buttons[row-1][col+1]))
      ans ++;
  if (isValid(row, col-1) == true)
    if (mines.contains(buttons[row][col-1]))
      ans ++;
  if (isValid(row, col+1) == true)
    if (mines.contains(buttons[row][col+1]))
      ans ++;
  if (isValid(row+1, col-1) == true)
    if (mines.contains(buttons[row+1][col-1]))
      ans ++;
  if (isValid(row+1, col) == true)
    if (mines.contains(buttons[row+1][col]))
      ans ++;
  if (isValid(row+1, col+1) == true)
    if (mines.contains(buttons[row+1][col+1]))
      ans ++;
  return ans;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col;
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager

  public void mousePressed ()
  {
    clicked = true;
    if (mouseButton == RIGHT) {
      if (flagged == true) {
        flagged = false;
      } else if (flagged == false) {
        flagged = true;
        clicked = false;
      }
    } else if (mines.contains(buttons[myRow][myCol]))
      displayLosingMessage();
    else if (countMines(myRow, myCol) > 0)
      buttons[myRow][myCol].myLabel = ""+ countMines(myRow, myCol);
    else {
      if (isValid(myRow-1, myCol-1) == true &&
        buttons[myRow - 1][myCol - 1].clicked == false) {
        buttons[myRow - 1][myCol - 1].mousePressed();
        //buttons[myRow - 1][myCol - 1].flagged = true;
      }
      if (isValid(myRow-1, myCol) == true &&
        buttons[myRow - 1][myCol].clicked == false) {
        buttons[myRow - 1][myCol].mousePressed();
        // buttons[myRow - 1][myCol].flagged = true;
      }
      if (isValid(myRow-1, myCol+1) == true &&
        buttons[myRow - 1][myCol + 1].clicked == false) {
        buttons[myRow - 1][myCol + 1].mousePressed();
        //  buttons[myRow - 1][myCol + 1].flagged = true;
      }
      if (isValid(myRow, myCol-1) == true &&
        buttons[myRow][myCol - 1].clicked == false) {
        buttons[myRow][myCol - 1].mousePressed();
        //   buttons[myRow][myCol - 1].flagged = true;
      }
      if (isValid(myRow, myCol) == true &&
        buttons[myRow][myCol].clicked == false) {
        buttons[myRow][myCol].mousePressed();
        //   buttons[myRow][myCol - 1].flagged = true;
      }
      if (isValid(myRow, myCol+1) == true &&
        buttons[myRow ][myCol + 1].clicked == false) {
        buttons[myRow][myCol + 1].mousePressed();
        //   buttons[myRow][myCol + 1].flagged = true;
      }
      if (isValid(myRow+1, myCol-1) == true &&
        buttons[myRow + 1][myCol - 1].clicked == false) {
        buttons[myRow + 1][myCol - 1].mousePressed();
        //   buttons[myRow + 1][myCol - 1].flagged = true;
      }
      if (isValid(myRow+1, myCol) == true &&
        buttons[myRow + 1][myCol].clicked == false) {
        buttons[myRow + 1][myCol].mousePressed();
        //  buttons[myRow + 1][myCol].flagged = true;
      }
      if (isValid(myRow + 1, myCol + 1) == true &&
        buttons[myRow + 1][myCol + 1].clicked == false) {
        buttons[myRow + 1][myCol + 1].mousePressed();
        //  buttons[myRow + 1][myCol + 1].flagged = true;
      }
    }
  }
  public void draw ()
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) )
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else
      fill( 100 );
    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}  
