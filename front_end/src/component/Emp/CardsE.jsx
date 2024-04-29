import EmployeCards from "./EmployeCards";
const CardsE = () => {
  return (
    <section className="bg-white py-16">
      <div className="container mx-auto">
        <h1 className="animate-pulse text-4xl font-bold text-center  text-navy-500 transition-colors duration-1000">
          Empolye services
        </h1>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {/* please edite the cards */}

          <EmployeCards title={"Add course mark"} details={"hi"} />
          <EmployeCards title={"Add Warring"} details={""} />
          <EmployeCards title={"Add Adress to Student"} details={""} />
          <EmployeCards title={"RAdd Adress to professor"} details={""} />
        </div>
      </div>
    </section>
  );
};

export default CardsE;
