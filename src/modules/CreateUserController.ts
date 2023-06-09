import { Request, Response } from "express";
// import { CreateUserUseCase } from "./CreateUserUseCase";
import { prisma } from "../prisma/client";


export class CreateUserController {
  async handle(req: Request, res: Response) {
    const { name, email, id_empresa } = req.body;

    const usuario_existe = await prisma.u ({

      where: {
        email
      }
    });

    if(usuario_existe){

      return res.status(404).json("user already exists");
    }
    
    const user = await prisma.usuarios.create({
      

      data:{
        name,
        email
        


      }
    });


    return res.status(201).json(user);
  }
  
}

// import { Request, Response } from 'express';
// import { prismaClient } from '../database/prismaClient';
// export class CreateUsuariosController {
//     async handle(request: Request, response: Response) {
//         const { id_empresa, codigo_vend, nome_user, senha, email } = request.body;

//         const usuarios = await prismaClient.usuarios.create({
//             data: {
//                 id_empresa,
//                 codigo_vend,
//                 nome_user,
//                 senha,
//                 email
//             }
//         })
//         return response.json(usuarios);
//     }
// }