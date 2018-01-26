public class Paginate 
    {
        public Integer index {get;set;}
        public Integer pageNum {get;set;}
        public Integer totalPage {get;set;}
        public Integer totalResults {get;set;}
        public List<Pager> pageList {get;set;}
        public Boolean showPrevious {get;set;}
        public Boolean showNext {get;set;}
        public Boolean isAll {get;set;}
        
        /**
        * This is for class constructor to initalize with default values
        *  @name Paginate
        *  @param Integer,integer
        *  @return 
        *  @throws 
        */  
        public Paginate(Integer listSize, Integer pageSize)
        {
            this.totalResults = listSize;
            pageSize = (pageSize > 0)?pageSize:10;
            this.totalPage = (Integer)Math.ceil((Double)listSize / (Double)pageSize);
            this.pageNum = 1;
            this.index = 0;
            this.isAll = (listSize == pageSize)?true:false;
            updateNumbers();
        }
        
        /**
        * This is for updating the numbers
        *  @name updateNumbers
        *  @param 
        *  @return void 
        *  @throws 
        */  
        public void updateNumbers()
        {
            this.pageList = new List<Pager>();
            for(Integer i = 1; i < (this.totalPage + 1); i++)
            {
                Boolean b = (i == pageNum)?true:false;
                this.pageList.add(new Pager(i, b));
            }
            this.showPrevious = (this.pageNum == 1)?false:true;
            this.showNext = (this.pageNum == this.totalPage)?false:true;
            this.index = this.pageNum - 1;
        }

      
        /**
        * This is for decremeting the numbers
        *  @name decrement
        *  @param 
        *  @return void 
        *  @throws 
        */ 
       public void decrement()
       {
            this.pageNum = this.pageNum - 1;
            updateNumbers();
       }

        /**
        * This is for increment the numbers
        *  @name increment
        *  @param 
        *  @return void 
        *  @throws 
        */ 
       public void increment()
       {
            this.pageNum++;
            updateNumbers();
       }


        public class Pager
        {
            public Integer pageNum {get;set;}
            public Boolean isActive {get;set;}
    
            public Pager(Integer num, Boolean active){
                this.pageNum = num;
                this.isActive = active;
            }
        }
}