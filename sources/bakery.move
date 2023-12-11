module bakery::bakery {

    // IMPORTS
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    
    // FLOUR OBJECT -----------------------------------------
    struct Flour has key , store{
       id: UID,
        
    }

    // function to create a new object and return the object, as a public entry fun can transfer but not return an object
    fun new_flour( ctx: &mut TxContext): Flour {
        Flour {
          
          id: object::new(ctx),
            
        }
    }


    // function to create the flour object and tansfer it to the caller of the function
    public entry fun create_flour(ctx: &mut TxContext) {
        let flour = new_flour(ctx);
        transfer::transfer(flour, tx_context::sender(ctx))
    }   
 
    // function to deconstruct and delete the flour object
    public entry fun delete_flour(flour: Flour) {

        let Flour {
             id 
             } = flour;
        
        object::delete(id);
    }

    
    // SALT OBJECT -----------------------------------------
    // follows the same structure as the Flour object
    struct Salt has key, store {
       id: UID,
        
    }

    
    fun new_salt( ctx: &mut TxContext): Salt {
        Salt {
          
          id: object::new(ctx),
            
        }
    }


    
    public entry fun create_salt(ctx: &mut TxContext) {
        let salt = new_salt(ctx);
        transfer::transfer(salt, tx_context::sender(ctx))
    }   
    

    public entry fun delete_salt(salt: Salt) {
        
        let Salt {
             id 
             } = salt;
        
        object::delete(id);
    }


    
    // YEAST OBJECT -----------------------------------------
    // follows the same structure as the Flour object
    struct Yeast has key, store {
       id: UID,
        
    }

    
    fun new_yeast( ctx: &mut TxContext): Yeast {
        Yeast {
          
          id: object::new(ctx),
            
        }
    }


    
    public entry fun create_yeast(ctx: &mut TxContext) {
        let yeast = new_yeast(ctx);
        transfer::transfer(yeast, tx_context::sender(ctx))
    }   
    

    public entry fun delete_yeast(yeast: Yeast) {
        
        let Yeast {
             id 
             } = yeast;
        
        object::delete(id);
    }


    
    // DOUGH OBJECT -----------------------------------------
    // follows the same structure as the Flour object with the exception of the create_dough function
    struct Dough has key, store {
        id: UID,
        
    }

    
    // function to take in Flour, Salt, and Yeast objects, delete them and create the dough object and transfer it to the caller of the function
    public entry fun create_dough(flour: Flour, salt: Salt, yeast: Yeast, ctx: &mut TxContext) {
        
         let Flour {
             id 
             } = flour;
        
        object::delete(id);

        let Salt {
             id 
             } = salt;
        
        object::delete(id);

        let Yeast {
             id 
             } = yeast;
        
        object::delete(id);
        
        let dough = new_dough(ctx);
        transfer::transfer(dough, tx_context::sender(ctx))
    }   

    
     fun new_dough( ctx: &mut TxContext): Dough {
        Dough {
          
          id: object::new(ctx),
            
        }
    }

    
    public entry fun delete_dough(dough: Dough) {
        
        let Dough {
             id 
             } = dough;
        
        object::delete(id);
    }


    
    // BREAD OBJECT -----------------------------------------
    // follows the same structure as the Flour object with the exception of the create_bread function
    struct Bread has key, store {
        id: UID,
        
    }

    // function to take in Dough object, delete them and create the bread object and transfer it to the caller of the function
    public entry fun create_bread(dough: Dough, ctx: &mut TxContext) {
        
         let Dough {
             id 
             } = dough;
        
        object::delete(id);
 
        let bread = new_bread(ctx);
        transfer::transfer(bread, tx_context::sender(ctx))
    }   

    
     fun new_bread( ctx: &mut TxContext): Bread {
        Bread {
          
          id: object::new(ctx),
            
        }
    }

    

    public entry fun delete_bread(bread: Bread) {
        
        let Bread {
             id 
             } = bread;
        
        object::delete(id);
    }

    
   // ----------------------------------------------------
   // TESTS
   // ----------------------------------------------------

    #[test_only] use sui::test_scenario as ts;

    #[test_only] const ADMIN: address = @0xAD;

    #[test]
     public fun test_bakery() {

        let ts = ts::begin(@0x0);

        
        // first transaction to emulate module initialization.
        {
            ts::next_tx(&mut ts, ADMIN);
            
        };
        
        // tx 2: Create Flour, Salt, Yeast
        {
            ts::next_tx(&mut ts, ADMIN);

            // Because the create functions are entry functions they do not return anything but transfer 
            create_flour(ts::ctx(&mut ts));
            create_salt(ts::ctx(&mut ts));
            create_yeast(ts::ctx(&mut ts));

            // Retrieve the objects from the sender's address
            let flour: Flour = ts::take_from_sender(&mut ts);
            let salt: Salt = ts::take_from_sender(&mut ts);
            let yeast: Yeast = ts::take_from_sender(&mut ts);            

            // Attempt to delete the objects and assert their existence
            delete_flour(flour);
            delete_salt(salt);
            delete_yeast(yeast);

        };

        // tx 3: Create Dough
        
        {
            ts::next_tx(&mut ts, ADMIN);

            let flour = ts::take_from_sender<Flour>(&mut ts);
            let salt = ts::take_from_sender<Salt>(&mut ts);
            let yeast = ts::take_from_sender<Yeast>(&mut ts);

            create_dough(flour, salt, yeast, ts::ctx(&mut ts));

            let dough: Dough = ts::take_from_sender(&mut ts);


            // Ensure dough is created by deleting it
            delete_dough(dough);

        };

        // tx 4: Create Bread
        {
            let dough: Dough = ts::take_from_sender(&mut ts);
            create_bread(dough, ts::ctx(&mut ts));

            // Ensure bread is created
            let bread: Bread = ts::take_from_sender(&mut ts);


            delete_bread(bread);

            

        };

        ts::end(ts);
    
        
    }

}
