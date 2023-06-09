import { Request, Response } from "express";
// import { CreateUserUseCase } from "./CreateUserUseCase";
import { prisma } from "../prisma/client";
// import { GetMoviesByReleaseDateUseCase } from "./GetMoviesByReleaseDateUseCase";

export class GetMoviesByReleaseDateController {
    async handle(req: Request, res: Response) {

        const movies = await prisma.movie.findMany({
            orderBy:{
                release_date: "desc"
            },
            include:{
                movie_rent: {
                    select: {
                        user:{
                            select:{
                                name: true,
                                email: true,

                            }
                        }
                    }
                }
                 
            },

        });
    
        return res.status(201).json(movies); 

    }

}
