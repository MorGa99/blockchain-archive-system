const EmployeCards = ({ title, details }) => {
  return (
    <div className=" bg-gray-200 rounded-lg shadow-2xl  m-6   bg-sky-100">
      <h1 className="p-6 text-2xl font-bold text-gray-900 text-center">
        {title}
      </h1>
      <div className="px-32">
        <button className="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded flex items-center shadow">
          {title}
        </button>
      </div>
      <p className=" p-6 text-gray-900 font-bold ">{details}</p>
    </div>
  );
};
export default EmployeCards;
