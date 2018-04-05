public class CatCounter {
	public Integer cat_count = 0;
    
    public void addCat(){
        ++cat_count;
    }
    
    public void addTenCats(){
        cat_count+=10;
    }
    
    public static void execute(){
        CatCounter cats = new CatCounter();
        cats.cat_count = 10;
        cats.addCat();
        cats.addTenCats();
        cats.addCat();
    }
    
   
    public static void executeCatNames(){
        List<String> cat_names = new List<String>();
        cat_names.add('Vas`ka');
        for(Integer i = 0; i<5; i++){
            String name = 'Cat' + i;
            cat_names.add(name);
        }
        
    }
}