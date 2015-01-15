import rigidPhysipoi.*;

/*
このサンプルはrigidPhysipoiの使い方をざっくり説明するものです。
 左クリックでボールを生成、右ドラックで壁を生成します。
 */

ArrayList<MSphere>mov=new ArrayList<MSphere>();
ArrayList<MEdge>edge=new ArrayList<MEdge>();

PVector wind=new PVector(0, -0.05);

void setup() {
  size(800, 600);

  edge.add(new MEdge(new PVector(5, height-5), 0, width-10));
  edge.add(new MEdge(new PVector(width-10, 0), HALF_PI, height));
  edge.add(new MEdge(new PVector(10, 0), HALF_PI, height));

  textAlign(CENTER);
}

void mouseClicked() {
}

int px=-1, py=-1;
void mousePressed() {
  if (mouseButton==RIGHT) {
    px=mouseX;
    py=mouseY;
  } else {
    mov.add(new  MSphere(mouseX, mouseY, 10, 20));
  }
}

void mouseReleased() {
  if (px!=-1&&py!=-1&&(px!=mouseX||py!=mouseY))
    edge.add(new MEdge(new PVector(mouseX, mouseY), new PVector(px, py)));
  px=py=-1;
}

void draw() {
  background(255);

  if (px!=-1&&py!=-1)
    line(px, py, mouseX, mouseY);

  for (MSphere m : mov) {
    m.applyForce(wind);
    m.update();
    for (MEdge e : edge)
      m.checkEdges(e);
  }

  for (MSphere m : mov)
    m.display();

  for (MEdge e : edge)
    e.display();
}

public class MEdge extends Edge {
  public MEdge(PVector l, PVector t) {
    super(l, t);
  }
  public MEdge(PVector l, float d, float len) {
    super(l, d, len);
  }

  public void display() {
    stroke(#aaaaff);
    strokeWeight(5);
    line(location.x, location.y, to.x, to.y);
  }
}

public class MSphere extends Sphere {
  public MSphere(float x, float y, float m, float r) {
    super(x, y, m, r);
  }

  public void display() {
    strokeWeight(1);
    stroke(0);
    fill(175, 100);
    ellipse(location.x, location.y, getR()*2, getR()*2);
  }
}

