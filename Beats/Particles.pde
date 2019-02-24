public class ParticleSystem
{
  private ArrayList<Particle> particles;
  private PImage sprite;
  private boolean active;
  private int particleSize;
  private float maxScale;
  private float spawnDelay;
  private float spawnTimer;
  private float spawnOriginX, spawnOriginY;
  private float spawnRangeX, spawnRangeY;
  private float minVelocity, maxVelocity;
  private float minLifetime, maxLifetime;

  public ParticleSystem(String spriteFilepath, int particleSize, float emissionRate, float maxScale, float spawnOriginX, float spawnOriginY, 
                        float spawnRangeX, float spawnRangeY, float minVelocity, float maxVelocity,
                        float minLifetime, float maxLifetime)
  {
    particles = new ArrayList<Particle>();
    setParticleSize(particleSize);
    setEmissionRate(emissionRate);
    setMaxScale(maxScale);
    setSpawnOrigin(spawnOriginX, spawnOriginY);
    setSpawnRange(spawnRangeX, spawnRangeY);
    setVelocityRange(minVelocity, maxVelocity);
    setLifetimeRange(minLifetime, maxLifetime);
    setSprite(spriteFilepath);
  }

  public void spawnParticle()
  {
    float spawnPositionX = spawnOriginX + random(-spawnRangeX, spawnRangeX);
    float spawnPositionY = spawnOriginY + random(-spawnRangeY, spawnRangeY);
    float spawnVelocityX = random(minVelocity, maxVelocity) * cos(random(0, 2*PI));
    float spawnVelocityY = random(minVelocity, maxVelocity) * sin(random(0, 2*PI));
    float lifetime = random(minLifetime, maxLifetime);
    particles.add(new Particle(this, sprite, maxScale, spawnPositionX, spawnPositionY, spawnVelocityX, spawnVelocityY, lifetime));
  }

  public void update()
  {
    spawnTimer += Timer.deltaTime;
    if (spawnTimer > spawnDelay && active)
    {
      spawnTimer = 0;
      spawnParticle();
    }
    
    for (int i = 0; i < particles.size(); i++)
    {
      particles.get(i).update();
    }
  }

  public void destroy(Particle particle)
  {
    particles.remove(particle);
  }
  
  public void setSprite(String spriteFilepath)
  {
    PImage sprite = loadImage(spriteFilepath); 
    sprite.resize(particleSize, particleSize);
    this.sprite = sprite;
  }
  
  public boolean isActive()
  {
    return active;
  }
  
  public void setActive(boolean active)
  {
    this.active = active; 
  }
  
  public void setParticleSize(int particleSize)
  {
    this.particleSize = particleSize;
  }

  public void setEmissionRate(float emissionRate)
  {
    spawnDelay = 1.0 / emissionRate;
  }
  
  public void setMaxScale(float maxScale)
  {
    this.maxScale = maxScale; 
  }

  public void setSpawnOrigin(float spawnOriginX, float spawnOriginY)
  {
    this.spawnOriginX = spawnOriginX;
    this.spawnOriginY = spawnOriginY;
  }

  public void setSpawnRange(float spawnRangeX, float spawnRangeY)
  {
    this.spawnRangeX = spawnRangeX;
    this.spawnRangeY = spawnRangeY;
  }

  public void setVelocityRange(float minVelocity, float maxVelocity)
  {
    this.minVelocity = minVelocity;
    this.maxVelocity = maxVelocity;
  }
  
  public void setLifetimeRange(float minLifetime, float maxLifetime)
  {
    this.minLifetime = minLifetime;
    this.maxLifetime = maxLifetime;
  }
}

class Particle
{
  private ParticleSystem particleSystem;
  private PImage sprite;
  private float positionX, positionY, velocityX, velocityY;
  private float transparency, fade;
  private float scale, growth;
  private float lifetime;
  private float destroyTimer;

  public Particle(ParticleSystem particleSystem, PImage sprite, float maxScale, float positionX, float positionY, float velocityX, float velocityY, float lifetime)
  {
    this.sprite = sprite;
    this.particleSystem = particleSystem;
    this.positionX = positionX;
    this.positionY = positionY;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
    transparency = 255;
    fade = -255 / lifetime;
    scale = 1.0;
    growth = (maxScale - 1.0) / lifetime;
    this.lifetime = lifetime;
  }

  public void update()
  {
    destroyTimer += Timer.deltaTime;
    
    positionX += velocityX;
    positionY += velocityY;
    transparency += fade * Timer.deltaTime;
    scale += growth * Timer.deltaTime;
    
    if (outOfFrame() || destroyTimer > lifetime)
    {
      particleSystem.destroy(this);
    }
    
    pushMatrix();
    translate(positionX, positionY);
    scale(scale);
    imageMode(CENTER);
    tint(255, transparency);
    image(sprite, 0, 0);
    imageMode(CORNER);
    tint(255, 255);
    popMatrix();
  }

  boolean outOfFrame()
  {
    if (positionX > width || positionX < 0 || positionY > height || positionY < 0)
      return true;

    return false;
  }
}