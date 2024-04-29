const AdminCards = ({ title, details }) => {
  return (
    <div className=" bg-gray-200 rounded-lg shadow-2xl  m-6   bg-sky-100">
      <h1 className="p-6 text-2xl font-bold text-gray-900 text-center">
        {title}
      </h1>
      <div className="px-32"></div>
      <p className=" p-6 text-gray-900 font-bold ">{details}</p>
    </div>
  );
};
export default AdminCards;
