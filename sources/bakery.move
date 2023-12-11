module bakery::bakery {

    // imports
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    
    // FLOUR OBJECT
    struct Flour has key , store{
       id: UID,
        
    }

    
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

    
    // SALT OBJECT
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


    
    // YEAST OBJECT
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


    
    // DOUGH OBJECT
    struct Dough has key, store {
        id: UID,
        
    }

    
    // function to create the dough object and transfer it
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


    
    // BREAD OBJECT
    struct Bread has key, store {
        id: UID,
        
    }

    // function to create the bread object and return it
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

    
   // ------------------------------------
   // TESTS
   // ------------------------------------


    #[test]
    fun test_baking_process() {

        use sui::test_scenario;

        
        let admin = @0x123;
        let baker = @0x456;

        // Start test scenario
        let scenario_val = test_scenario::begin(admin);
        let scenario = &mut scenario_val;

        


        // tx 1: Create flour, salt, and yeast
        test_scenario::next_tx(scenario, baker);
        {
            // Because the create functions are entry functions they do not return anything but transfer 
            create_flour(test_scenario::ctx(scenario));
            create_salt(test_scenario::ctx(scenario));
            create_yeast(test_scenario::ctx(scenario));

            // Retrieve the objects from the sender's address
            let flour = test_scenario::take_from_sender<Flour>(scenario);
            let salt = test_scenario::take_from_sender<Salt>(scenario);
            let yeast = test_scenario::take_from_sender<Yeast>(scenario);

            // Attempt to delete the objects and assert their existence
            delete_flour(flour);
            delete_salt(salt);
            delete_yeast(yeast);


        };

        // tx 2: Create dough
        test_scenario::next_tx(scenario, baker);
        {
            let flour = test_scenario::take_from_sender<Flour>(scenario);
            let salt = test_scenario::take_from_sender<Salt>(scenario);
            let yeast = test_scenario::take_from_sender<Yeast>(scenario);

            create_dough(flour, salt, yeast, test_scenario::ctx(scenario));

            let dough = test_scenario::take_from_sender<Dough>(scenario);


            // Ensure dough is created by deleting it
            delete_dough(dough);

        };

        // tx 3: Create bread
        test_scenario::next_tx(scenario, baker);
        {
            let dough = test_scenario::take_from_sender<Dough>(scenario);
            create_bread(dough, test_scenario::ctx(scenario));

            // Ensure bread is created
            let bread = test_scenario::take_from_sender<Bread>(scenario);


            delete_bread(bread);

            

        };

        test_scenario::end(scenario_val);

    
        
    }

}
