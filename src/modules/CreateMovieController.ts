import { Request, Response } from "express";
// import { CreateUserUseCase } from "./CreateUserUseCase";
import { prisma } from "../prisma/client";

export class CreateMovieController {
    async handle(req: Request, res: Response) {
        const { title, duration, release_date } = req.body;

        const movieAlreadyExists = await prisma.movie.findUnique({

            where: {
                title
            }
        });

        if (movieAlreadyExists) {

            return res.status(404).json("movie already exists");
        }

        const movie = await prisma.movie.create({


            data: {
                title: title,
                duration: duration,
                release_date: release_date
            }
        });


        return res.status(201).json(movie);
    }

}
