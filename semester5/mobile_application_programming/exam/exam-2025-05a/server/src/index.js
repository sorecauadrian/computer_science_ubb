const Koa = require('koa');
const app = module.exports = new Koa();
const server = require('http').createServer(app.callback());
const WebSocket = require('ws');
const wss = new WebSocket.Server({ server });
const Router = require('koa-router');
const cors = require('@koa/cors');
const bodyParser = require('koa-bodyparser');

app.use(bodyParser());
app.use(cors());
app.use(middleware);

function middleware(ctx, next) {
  const start = new Date();
  return next().then(() => {
    const ms = new Date() - start;
    console.log(`${start.toLocaleTimeString()} ${ctx.response.status} ${ctx.request.method} ${ctx.request.url} - ${ms}ms`);
  });
}

const workouts = [
  { id: 1, name: "Morning Yoga", trainer: "Alice", description: "30 min yoga session", status: "planned", participants: 5, type: "yoga", duration: 30 },
  { id: 2, name: "Strength Training", trainer: "Bob", description: "Full-body strength routine", status: "in progress", participants: 10, type: "strength training", duration: 45 },
  { id: 3, name: "Cardio Blast", trainer: "Charlie", description: "High-intensity cardio workout", status: "completed", participants: 12, type: "cardio", duration: 40 },
  { id: 4, name: "Pilates Core", trainer: "Diana", description: "Pilates session focusing on core strength", status: "planned", participants: 6, type: "pilates", duration: 35 },
  { id: 5, name: "HIIT Burn", trainer: "Evan", description: "High-Intensity Interval Training", status: "in progress", participants: 15, type: "HIIT", duration: 30 },
  { id: 6, name: "Full-Body Workout", trainer: "Fiona", description: "Strength & endurance circuit", status: "completed", participants: 9, type: "strength training", duration: 50 },
  { id: 7, name: "Evening Stretch", trainer: "George", description: "Relaxing stretch session", status: "planned", participants: 4, type: "yoga", duration: 25 },
  { id: 8, name: "Endurance Run", trainer: "Hannah", description: "5K running endurance training", status: "in progress", participants: 20, type: "cardio", duration: 60 },
  { id: 9, name: "Bootcamp", trainer: "Ian", description: "Military-style full-body workout", status: "completed", participants: 18, type: "HIIT", duration: 55 },
  { id: 10, name: "Functional Fitness", trainer: "Jasmine", description: "Functional strength & mobility drills", status: "planned", participants: 7, type: "strength training", duration: 40 }
];


const router = new Router();

router.get('/workouts', ctx => {
  ctx.response.body = workouts;
  ctx.response.status = 200;
});

router.get('/workout/:id', ctx => {
  const { id } = ctx.params;
  const workout = workouts.find(w => w.id == id);
  if (workout) {
    ctx.response.body = workout;
    ctx.response.status = 200;
  } else {
    ctx.response.body = { error: `Workout with id ${id} not found` };
    ctx.response.status = 404;
  }
});

router.post('/workout', ctx => {
  const { name, trainer, description, status, participants, type, duration } = ctx.request.body;

  if (name && trainer && description && status && type && duration && participants) {
    const id = workouts.length > 0 ? Math.max(...workouts.map(w => w.id)) + 1 : 1;
    const newWorkout = { id, name, trainer, description, status, participants, type, duration };
    workouts.push(newWorkout);

    broadcast(newWorkout);
    ctx.response.body = newWorkout;
    ctx.response.status = 201;
  } else {
    console.log(`Missing or invalid fields, name: ${name} trainer: ${trainer} description: ${description} status: ${status} participants: ${participants} type: ${type} duration: ${duration}`);
    ctx.response.body = { error: "Missing or invalid fields, name: ${name} trainer: ${trainer} description: ${description} status: ${status} participants: ${participants} type: ${type} duration: ${duration}" };
    ctx.response.status = 400;
  }
});

router.put('/workout', ctx => {
  const { id, name, trainer, description, status, participants, type, duration } = ctx.request.body;

  const workout = workouts.find(w => w.id == id);
  if (workout && name && trainer && description && status && type && duration && participants) {
    workout.name = name;
    workout.trainer = trainer;
    workout.description = description;
    workout.status = status;
    workout.participants = participants;
    workout.type = type;
    workout.duration = duration;
    
    ctx.response.body = workout;
    ctx.response.status = 200;
  } else {
    console.log(`Workout not found or invalid fields, id: ${id} name: ${name} trainer: ${trainer} description: ${description} status: ${status} participants: ${participants} type: ${type} duration: ${duration}`);
    ctx.response.body = { error: `Workout not found or invalid fields, id: ${id} name: ${name} trainer: ${trainer} description: ${description} status: ${status} participants: ${participants} type: ${type} duration: ${duration}` };
    ctx.response.status = 400;
  }
});

router.get('/allWorkouts', ctx => {
  const inProgressWorkouts = workouts;
  ctx.response.body = inProgressWorkouts;
  ctx.response.status = 200;
});

const broadcast = (data) => {
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(data));
    }
  });
};

// Register routes
app.use(router.routes());
app.use(router.allowedMethods());

const port = 2505;
server.listen(port, () => {
  console.log(`💪 Workout Server running on port ${port}... 🚀`);
});
