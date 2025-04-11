const express = require('express');
const { Datastore } = require('@google-cloud/datastore');

const app = express();
const port = process.env.PORT || 8080; // Use environment variable for port if available

// --- Datastore Configuration ---
const datastore = new Datastore(); // Automatically uses Application Default Credentials
const KIND = 'Task'; // The kind for our data entities in Datastore

// --- Middleware ---
app.use(express.json()); // Middleware to parse JSON request bodies

// --- Basic Routes ---
app.get('/', (req, res) => {
    // Keep this simple route for basic health checks / probes
    res.status(200).send('Hello World! Service is running.');
});

// --- CRUD API Routes ---

// POST /data - Create a new task
app.post('/data', async (req, res) => {
    try {
        if (!req.body || !req.body.description) {
            return res.status(400).send('Missing "description" in request body.');
        }

        const taskKey = datastore.key(KIND); // Let Datastore generate an ID
        const newTask = {
            key: taskKey,
            data: {
                description: req.body.description,
                created: new Date(),
                done: false, // Example additional field
            },
        };

        await datastore.save(newTask);
        // Return the key (which includes the auto-generated ID) and data
        res.status(201).send({ id: taskKey.id, ...newTask.data });
    } catch (error) {
        console.error('ERROR saving data:', error);
        res.status(500).send('Failed to save data.');
    }
});

// GET /data/:id - Fetch a specific task by ID
app.get('/data/:id', async (req, res) => {
    try {
        const taskId = parseInt(req.params.id, 10); // Datastore IDs are numeric
        if (isNaN(taskId)) {
             return res.status(400).send('Invalid ID format. ID must be numeric.');
        }

        const taskKey = datastore.key([KIND, taskId]);
        const [task] = await datastore.get(taskKey);

        if (task) {
            // Add the ID to the returned object for convenience
            res.status(200).send({ id: taskKey.id, ...task });
        } else {
            res.status(404).send(`Task with ID ${taskId} not found.`);
        }
    } catch (error) {
        console.error(`ERROR fetching data for ID ${req.params.id}:`, error);
        res.status(500).send('Failed to fetch data.');
    }
});

// GET /data - Fetch all tasks
app.get('/data', async (req, res) => {
    try {
        const query = datastore.createQuery(KIND).order('created', { descending: true }); // Example order
        const [tasks] = await datastore.runQuery(query);

        // Add the ID to each task object
        const tasksWithIds = tasks.map(task => ({
            id: task[datastore.KEY].id,
            ...task
        }));

        res.status(200).send(tasksWithIds);
    } catch (error) {
        console.error('ERROR fetching all data:', error);
        res.status(500).send('Failed to fetch data.');
    }
});


// --- Server Start ---
app.listen(port, '0.0.0.0', () => {
    console.log(`Server running on port ${port}`);
    console.log(`Using Datastore Kind: ${KIND}`);
    // Log the project ID Datastore is configured to use (useful for debugging auth)
    console.log(`Datastore Project ID: ${datastore.projectId}`);
});
