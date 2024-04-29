import AdminCards from "./AdminCards";

const CardsA = () => {
  return (
    <section className="bg-white py-16">
      <div className="container mx-auto">
        <h1 className="animate-pulse text-4xl font-bold text-center  text-navy-500 transition-colors duration-1000">
          Admin services
        </h1>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {/* please edite the cards */}

          <AdminCards title={"Register Employee"} details={""} />

          {/* <AdminCards title={"Add course"} details={""} />
          <AdminCards title={"Register Employee"} details={""} />
          <AdminCards title={"Register Professor"} details={""} />
          <AdminCards title={"modifay Professor"} details={""} />
          <AdminCards title={"modifay Student"} details={""} />
          <AdminCards title={"Delete Student"} details={""} />
          <AdminCards title={"Delete Student"} details={""} />
          <AdminCards title={"Delete Student"} details={""} /> */}
        </div>
      </div>
    </section>
  );
};

export default CardsA;
