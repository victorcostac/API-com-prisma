import { Router } from "express";
import { CreateMovieController } from "../modules/CreateMovieController";
import { GetMoviesByReleaseDateController } from "../modules/GetMoviesByReleaseDateController";
import { CreateMovieRentController } from "../modules/createMovieRentController";

// import { GetAllUsersController } from "../modules/users/useCases/getAllUsers/GetAllUsersController";
const createMovieRentController = new CreateMovieRentController();
const createMovieController = new CreateMovieController();
// const getAllUsersController = new GetAllUsersController();

const getMoviesByReleaseDateController = new GetMoviesByReleaseDateController();
const movierentRoutes = Router();
const movieRoutes = Router();


movieRoutes.post("/movierent", createMovieRentController.handle);
movieRoutes.post("/movie", createMovieController.handle);
// userRoutes.get("/", getAllUsersController.handle);
movieRoutes.get("/release", getMoviesByReleaseDateController.handle);

export { movieRoutes };