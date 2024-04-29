import { Link, NavLink } from "react-router-dom";

const NavItem = ({ title }) => {
  return (
    <li>
      <NavLink
        to={title}
        className="block py-2 pl-3 pr-4 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-2 md:dark:text-blue-500"
        aria-current="page"
      >
        {title}
      </NavLink>
    </li>
  );
};

export default NavItem;
