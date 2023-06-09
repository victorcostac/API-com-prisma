import { Request, Response } from "express";
// import { CreateUserUseCase } from "./CreateUserUseCase";
import { prisma } from "../prisma/client";

export class CreateMovieRentController {
    async handle(req: Request, res: Response) {
        const { userId, movieId } = req.body;
        // verificar se existe
        const movieExists = await prisma.movie.findUnique({

            where: {
                id: movieId
            }
        });

        if (!movieExists) {

            return res.status(404).json("movie does not exist");
        }

        //verificar se não está alocado por outra pessoa
        const movieAlreadyRented = await prisma.movieRent.findFirst({
            where:{

                movieId 

            }
        
        });

        if(movieAlreadyRented){

            return res.status(404).json("movie already rented");

        }

        //verificar se o usuário existe
        const userExist = await prisma.user.findUnique({

            where:{
                
                id: userId

            }

        });

        if(!userExist){

            return res.status(404).json("user does not exists");

            }
        //criar locação
    
        await prisma.movieRent.create({

            data:{

                userId,
                movieId

            }
        })

        return res.status(201).send();

        }
        
        
        
    }


