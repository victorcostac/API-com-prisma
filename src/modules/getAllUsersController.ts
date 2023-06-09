import { Request, Response } from "express";
// import { CreateUserUseCase } from "./CreateUserUseCase";
import { prisma } from "../prisma/client";
import { GetaAllUserUseCase } from "./getAllUsersUseCase";

export class GetaAllUsersController {
  async handle(req: Request, res: Response) {
    
    const getAllUsersUseCase = new GetaAllUserUseCase();
    const result = await getAllUsersUseCase.execute();

    return res.status(201).json(result);
  }
  
}