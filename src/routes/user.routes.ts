import { Router } from "express";
import { CreateUserController } from "../modules/CreateUserController";
import { GetaAllUsersController } from "../modules/getAllUsersController";


// import { GetAllUsersController } from "../modules/users/useCases/getAllUsers/GetAllUsersController";

const createUserController = new CreateUserController();
// const getAllUsersController = new GetAllUsersController();
const getaAllUsersController = new GetaAllUsersController();

const userRoutes = Router();

userRoutes.post("/user", createUserController.handle);
// userRoutes.get("/", getAllUsersController.handle);
userRoutes.get("/getuser", getaAllUsersController.handle);

export { userRoutes };