
import express from "express";

import { userRoutes } from "./routes/user.routes";
import { movieRoutes } from "./routes/movie.routes";

const app = express();

app.use(express.json());

app.use(userRoutes);
app.use(movieRoutes);



app.listen(3333, () => console.log("Server is running in port 3333 🚀"));
