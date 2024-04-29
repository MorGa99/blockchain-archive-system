import HomeCard from "./HomeCard";


const Cards = () =>{
return ( 
    <section className="bg-white py-16">
        
    <div className="container mx-auto">
    <h1 className="animate-pulse text-4xl font-bold text-center  text-navy-500 transition-colors duration-1000">Enjoy  Out-Standing services</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8"> 
      {/* please edite the cards */ } 
     
      <HomeCard
       title={"Easy searching " } 
       imagelink={"/images/easybooking.jpg"}
       details={"easy user interface with simple icons for all kinds of users "}/> 
          
          <HomeCard 
       title={"modren archave Mrethod " } 
       imagelink={"/images/iStock-1370737372.jpg"}
       details={"blockchain is one of the most recent methods to make data Transparent and secur ."}/> 
        
        <HomeCard
       title={"navigat from Any Device  " } 
       imagelink={"/images/img_6273ec6d5c169.jpg"}
       details={""}/> 
        
    
      </div>
    </div>
  </section>
)
}

export default Cards ; 