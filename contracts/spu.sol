// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract spu {
    address is_admin;
    constructor() {
        is_admin = msg.sender;
    }

    //---------------------------------- structures ---------------------------------------------------------------
    struct course_grade {
        uint student_id;
        uint mark;
    }

    struct student_courses {
        uint couse_id;
        uint weekly_hours;
        uint mark;
    }

    struct course {
        uint id;
        string name;
        string weekly_hour;
        string level;
        course_grade[] students_grades;
    }

    struct prof {
        uint id;
        string firstName;
        string lastName;
        string fatherName;
        string motherName;
        string gender;
        string email;
        string collegeName;
        string dateOfBirth;
        string mobileNumber;
        string specialization;
        address prof_address;
    }

    struct student {
        uint id;
        string firstName;
        string lastName;
        string fatherName;
        string motherName;
        string gender;
        string email;
        string collegeName;
        string dateOfBirth;
        string mobileNumber;
        uint256 cumulative_averge;
        address student_address;
        string[] warnnings;
        student_courses[] all_courses;
    }

    //---------------------------------- tools ----------------------------------------------------------------------

    modifier onlyemp(address v) {
        require(ChekIfEmp(v) == true);
        _;
    }

    modifier onlyAdmin(address x) {
        require(x == is_admin);
        _;
    }

    uint public s_counter = 0;
    uint public p_counter = 0;
    uint public e_counter = 0;

    mapping(uint => address) private get_emp;
    mapping(uint => prof) private get_prof;
    mapping(uint => student) private get_student;
    mapping(uint => course) public get_course;

    address[] public all_employees;
    course[] public spu_courses;

    address[] private all_students;
    uint[] private all_students_id;

    address[] private all_profs;
    uint[] private all_profs_id;
    //------------------------------------- Auxiliary functions --------------------------------------

    function ChekIfEmp(address y) public view returns (bool b) {
        uint i = 0;
        while (i < e_counter) {
            i++;
            if (y == all_employees[i - 1]) return true;
            else return false;
        }
    }
    function ChekIfstudent(uint _id) private view returns (bool b) {
        for (uint i = 0; i < all_students_id.length; i++) {
            if (_id == all_students_id[i]) {
                return true;
            }
        }
        return false;
    }

    function ChekIfstudentaddress(address x) private view returns (bool b) {
        for (uint i = 0; i < all_students.length; i++) {
            if (x == all_students[i]) {
                return true;
            }
        }
        return false;
    }

    function ChekIfprofaddress(address x) private view returns (bool b) {
        for (uint i = 0; i < all_profs.length; i++) {
            if (x == all_profs[i]) {
                return true;
            }
        }
        return false;
    }

    function ChekIfprof(uint _id) private view returns (bool b) {
        for (uint i = 0; i < all_profs_id.length; i++) {
            if (_id == all_profs_id[i]) {
                return true;
            }
        }
        return false;
    }

    function add_mark_To_Student(
        uint course_id,
        uint w_h,
        uint s_id,
        uint _mark
    ) private {
        student storage s = get_student[s_id];
        student_courses memory f;
        f.couse_id = course_id;
        f.mark = _mark;
        f.weekly_hours = w_h;

        s.all_courses.push(f);
    }

    function set_cumulative_averge(uint student_id) private {
        student storage s = get_student[student_id];
        uint256 t_h = 0;
        uint256 v = 0;
        for (uint i = 0; i < s.all_courses.length; i++) {
            t_h = t_h + s.all_courses[i].weekly_hours;
            v = v + (s.all_courses[i].mark * s.all_courses[i].weekly_hours);
        }

        s.cumulative_averge = v / t_h;
    }

    function add_address_to_student(
        uint _id,
        address _address
    ) public onlyemp(msg.sender) returns (string memory) {
        string memory err = "id is not correct";
        string memory don = "entered successfully";

        if (ChekIfstudent(_id) == true) {
            student storage s = get_student[_id];
            s.student_address = _address;
            all_students.push(_address);
            return don;
        } else return err;
    }

    function add_address_to_prof(
        uint _id,
        address _address
    ) public onlyemp(msg.sender) returns (string memory) {
        string memory err = "id is not correct";
        string memory don = "entered successfully";

        if (ChekIfprof(_id) == true) {
            prof storage s = get_prof[_id];
            s.prof_address = _address;
            all_profs.push(_address);
            return don;
        } else return err;
    }

    function validateEmail(string memory _email) internal pure returns (bool) {
        bytes memory b = bytes(_email);
        uint emailLength = b.length;
        bool noAtSign = true;
        bool noDot = true;

        for (uint i = 0; i < emailLength; i++) {
            if (b[i] == "@") {
                noAtSign = false;
            }
            if (b[i] == ".") {
                noDot = false;
            }
        }

        return !noAtSign && !noDot;
    }
    function isValidDateFormat(
        string memory _date
    ) internal pure returns (bool) {
        bytes memory b = bytes(_date);
        if (b.length != 10) {
            return false;
        }

        if (b[4] != "-" || b[7] != "-") {
            return false;
        }

        for (uint i = 0; i < b.length; i++) {
            if (i == 4 || i == 7) {
                continue;
            }
            if (b[i] < "0" || b[i] > "9") {
                return false;
            }
        }

        return true;
    }
    //------------------------------------------ main functions ----------------------------------------------------
    function view_student(uint id) public view returns (student memory k) {
        if (msg.sender == is_admin) {
            return get_student[id];
        } else if (ChekIfEmp(msg.sender) == true) {
            return get_student[id];
        } else if (ChekIfstudentaddress(msg.sender) == true) {
            return get_student[id];
        } else if (ChekIfprofaddress(msg.sender) == true) {
            return get_student[id];
        } else {
            student storage s = get_student[id];
            student memory v;
            v.firstName = s.firstName;
            v.lastName = s.lastName;
            v.fatherName = s.fatherName;
            v.motherName = s.motherName;
            v.gender = s.gender;
            v.email = "null";
            v.collegeName = s.collegeName;
            v.dateOfBirth = s.dateOfBirth;
            v.mobileNumber = "null";
            v.cumulative_averge = s.cumulative_averge;
            v.student_address = 0x0000000000000000000000000000000000000000;
            v.warnnings = s.warnnings;
            v.all_courses = s.all_courses;
            return v;
        }
    }

    function Add_corse(
        uint id,
        string memory name,
        string memory weekly_hour,
        string memory level
    ) public onlyAdmin(msg.sender) {
        course storage b = get_course[id];
        b.id = id;
        b.name = name;
        b.weekly_hour = weekly_hour;
        b.level = level;
        spu_courses.push(b);
    }

    function add_course_marks(
        uint course_id,
        uint w_h,
        uint student_id,
        uint _mark
    ) public onlyemp(msg.sender) {
        course storage c = get_course[course_id];
        course_grade memory g;
        g.student_id = student_id;
        g.mark = _mark;
        c.students_grades.push(g);

        add_mark_To_Student(course_id, w_h, student_id, _mark);
        set_cumulative_averge(student_id);
    }

    function register_student(
        uint _id,
        string memory _firstName,
        string memory _lastName,
        string memory _fatherName,
        string memory _motherName,
        string memory _gender,
        string memory _email,
        string memory _collegeName,
        string memory _dateOfBirth,
        string memory _mobileNumber
    ) public onlyAdmin(msg.sender) {
        require(_id > 0);
        require(bytes(_firstName).length > 0);
        require(bytes(_lastName).length > 0);
        require(bytes(_fatherName).length > 0);
        require(bytes(_motherName).length > 0);
        require(bytes(_gender).length > 0);
        require(bytes(_email).length > 0);
        require(validateEmail(_email));
        require(bytes(_collegeName).length > 0);
        require(bytes(_dateOfBirth).length > 0);
        require(isValidDateFormat(_dateOfBirth));
        require(bytes(_mobileNumber).length > 0);
        require(get_student[_id].id == 0);

        student storage s = get_student[_id];
        s.id = _id;
        s.firstName = _firstName;
        s.lastName = _lastName;
        s.fatherName = _fatherName;
        s.motherName = _motherName;
        s.gender = _gender;
        s.email = _email;
        s.collegeName = _collegeName;
        s.dateOfBirth = _dateOfBirth;
        s.mobileNumber = _mobileNumber;

        all_students_id.push(_id);
        s_counter++;
    }

    function register_prof(
        uint _id,
        string memory _firstName,
        string memory _lastName,
        string memory _fatherName,
        string memory _motherName,
        string memory _gender,
        string memory _email,
        string memory _collegeName,
        string memory _dateOfBirth,
        string memory _mobileNumber,
        string memory _specialization
    ) public onlyAdmin(msg.sender) {
        require(_id > 0);
        require(bytes(_firstName).length > 0);
        require(bytes(_lastName).length > 0);
        require(bytes(_fatherName).length > 0);
        require(bytes(_motherName).length > 0);
        require(bytes(_gender).length > 0);
        require(bytes(_email).length > 0);
        require(validateEmail(_email));
        require(bytes(_collegeName).length > 0);
        require(bytes(_dateOfBirth).length > 0);
        require(isValidDateFormat(_dateOfBirth));
        require(bytes(_mobileNumber).length > 0);
        require(bytes(_specialization).length > 0);
        require(get_prof[_id].id == 0);

        prof storage s = get_prof[_id];

        s.id = _id;
        s.firstName = _firstName;
        s.lastName = _lastName;
        s.fatherName = _fatherName;
        s.motherName = _motherName;
        s.gender = _gender;
        s.email = _email;
        s.collegeName = _collegeName;
        s.dateOfBirth = _dateOfBirth;
        s.mobileNumber = _mobileNumber;
        s.specialization = _specialization;

        all_profs_id.push(_id);

        p_counter++;
    }

    function register_emp(address _x) public onlyAdmin(msg.sender) {
        get_emp[e_counter] = _x;
        all_employees.push(_x);
        e_counter++;
    }

    function add_warnning(
        uint _id,
        string memory _warnning
    ) public onlyemp(msg.sender) {
        string memory w = _warnning;
        get_student[_id].warnnings.push(w);
    }

    function get_Courses_Of_Student(
        uint _id
    ) public view returns (student_courses[] memory) {
        return get_student[_id].all_courses;
    }

    function get_warnnings(uint _id) public view returns (string[] memory b) {
        string[] memory e;
        e = get_student[_id].warnnings;
        return e;
    }

    function Delet_emp(uint n) public onlyAdmin(msg.sender) {
        delete all_employees[n];
        delete get_emp[n];

        for (uint i = n; i < all_employees.length; i++) {
            all_employees[n] = all_employees[all_employees.length - 1];
        }
        e_counter--;
    }

    function deleteStudent(uint _id) public onlyAdmin(msg.sender) {
        require(ChekIfstudent(_id));

        delete get_student[_id];
        uint indexToDelete;
        for (uint i = 0; i < all_students_id.length; i++) {
            if (all_students_id[i] == _id) {
                indexToDelete = i;
                break;
            }
        }

        if (indexToDelete < all_students_id.length) {
            all_students_id[indexToDelete] = all_students_id[
                all_students_id.length - 1
            ];
            all_students_id.pop();
        }
        s_counter--;
    }

    function deleteProfessor(uint _id) public onlyAdmin(msg.sender) {
        require(ChekIfprof(_id));

        delete get_prof[_id];
        uint indexToDelete;
        for (uint i = 0; i < all_profs_id.length; i++) {
            if (all_profs_id[i] == _id) {
                indexToDelete = i;
                break;
            }
        }

        if (indexToDelete < all_profs_id.length) {
            all_profs_id[indexToDelete] = all_profs_id[all_profs_id.length - 1];
            all_profs_id.pop();
        }
        p_counter--;
    }

    function modifyStudent(
        uint _id,
        string memory _firstName,
        string memory _lastName,
        string memory _fatherName,
        string memory _motherName,
        string memory _gender,
        string memory _email,
        string memory _collegeName,
        string memory _dateOfBirth,
        string memory _mobileNumber
    ) public onlyAdmin(msg.sender) {
        require(get_student[_id].id == _id);

        student storage s = get_student[_id];
        s.firstName = _firstName;
        s.lastName = _lastName;
        s.fatherName = _fatherName;
        s.motherName = _motherName;
        s.gender = _gender;
        s.email = _email;
        s.collegeName = _collegeName;
        s.dateOfBirth = _dateOfBirth;
        s.mobileNumber = _mobileNumber;
    }

    function modifyprof(
        uint _id,
        string memory _firstName,
        string memory _lastName,
        string memory _fatherName,
        string memory _motherName,
        string memory _gender,
        string memory _email,
        string memory _collegeName,
        string memory _dateOfBirth,
        string memory _mobileNumber,
        string memory _specialization
    ) public onlyAdmin(msg.sender) {
        require(get_prof[_id].id == _id);

        prof storage s = get_prof[_id];
        s.firstName = _firstName;
        s.lastName = _lastName;
        s.fatherName = _fatherName;
        s.motherName = _motherName;
        s.gender = _gender;
        s.email = _email;
        s.collegeName = _collegeName;
        s.dateOfBirth = _dateOfBirth;
        s.mobileNumber = _mobileNumber;
        s.specialization = _specialization;
    }
}
