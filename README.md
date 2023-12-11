# SUI_Move_Bootcamp_Final_Project

**Project Overview:**

---

- The explanation of the project including the aim of the project.

---

- **The devnet contract address.**

As a Windows/ Linux VM user after needing to reinstall the SUI binaries I have recieved the known error pertaining to the Random.Move file. 

![known error without fix](./Screenshot1.jpg)

Being on the SUI Discord and asking about the issue I see it is a known issue with some workarounds proposed, but I was unable to get them to work.

---
---
 
The work around is to comment out these lines in the fun create(ctx: &mut TxContext) in the Random.Move file:

    // let inner = RandomInner {
    //     version, 
    //     epoch: tx_context::epoch(ctx),
    //     random_bytes: vector[],
    // };
  
    // let self = Rnadom {
    //     id: object::randomness_state(),
    //     inner: versioned::create(version, inner, ctx),
    // };
    // transfer::share_object(self)

  Then to build use this command:

    sui move build --skip-fetch-latest-git-deps

  ---
  ---

  To deploy a built Sui move package I would use the command: sui move build --skip-fetch-latest-git-deps
  
    
        sui client publish --gas-budget 10000000
   
  After the package is copiled it can be checked in the SUI explorer. 

---

- **How to set up the project. In this part, you can also share the following link for Move on Sui setup: Install Sui to Build | Sui Docs**

  - As a reuslt of the knwon bug and not getting the SUI binaries to properly install on my machine it gave me the unique ability to use the Welldone wallet on the Remix IDE. With the Welldone wallet it is possible to crete a multiude of template projects but i chose the basic which created an empty source folder and an empty Move.toml file. 
  The project built using this method allowed the functions to be tested but gave limited access to the #[test] functions.


---


- **How to run the project.**
- 
The project can be run by first building the project woth 

        sui move build
   
and the project can have the functions called using the Remix IDE with the Welldone wallet. The funcitons allow the for the creation and deletion of the objects in the file.
    
---

- **How to test the project.**

        sui move test

  will run the tests located at the bottom of the file. 

