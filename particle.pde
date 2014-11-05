class Particle{

  color c;

  PVector position;
  PVector velocity;
  PVector oldPosition;
  int h;
  
  Particle(PVector pos, PVector vel){
    oldPosition = pos.get();
    velocity = vel;
    position = pos;
    h = floor(255*noise(t));
  }
  
  void perturb(PVector[] forces) {
    oldPosition = position.get();
    // Update the position with the velocity.
    position.add(velocity);
    // Update the velocity with the forces acting on the
    // particle (which, since we're assuming a constant
    // time delta and constant mass, just means that change
    // in velocity equals vector sum of the forces)
    for(int i = 0; i < forces.length; ++i) {
      velocity.add(forces[i]);
    }
  }

}
