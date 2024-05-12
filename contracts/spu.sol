// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract spu {
    address is_admin;
    constructor() {
        is_admin = msg.sender;
    }

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
        string college;
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

    address[] public authorized;

    function checkRole(address a) public view returns (uint) {
        if (a == is_admin) {
            return 1;
        } else if (ChekIfEmp(msg.sender) == true) {
            return 2;
        } else if (
            ChekIfauthorizedaddress(msg.sender) == true ||
            ChekIfprofaddress(msg.sender) == true
        ) {
            return 3;
        } else {
            return 4;
        }
    }
    function ChekIfEmp(address y) public view returns (bool b) {
        for (uint i = 0; i < all_employees.length; i++) {
            if (y == all_employees[i]) {
                return true;
            }
        }
        return false;
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
    function ChekIfauthorizedaddress(address x) private view returns (bool b) {
        for (uint i = 0; i < authorized.length; i++) {
            if (x == authorized[i]) {
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
    ) public onlyemp(msg.sender) {
        if (ChekIfstudent(_id) == true) {
            student storage s = get_student[_id];
            s.student_address = _address;
            all_students.push(_address);
        }
    }

    function add_address_to_prof(
        uint _id,
        address _address
    ) public onlyemp(msg.sender) {
        if (ChekIfprof(_id) == true) {
            prof storage s = get_prof[_id];
            s.prof_address = _address;
            all_profs.push(_address);
        }
    }
    function addaythorizedad(address A) public onlyemp(msg.sender) {
        authorized.push(A);
    }
    function view_student(uint id) public view returns (student memory k) {
        if (
            (msg.sender) == is_admin ||
            ChekIfEmp(msg.sender) == true ||
            (ChekIfstudentaddress(msg.sender) == true &&
                get_student[id].student_address == (msg.sender)) ||
            ChekIfprofaddress(msg.sender) == true ||
            ChekIfauthorizedaddress(msg.sender) == true
        ) {
            return get_student[id];
        } else {
            student memory v = get_student[id];
            v.email = "null";
            v.mobileNumber = "null";
            v.student_address = 0x0000000000000000000000000000000000000000;
            v.warnnings = new string[](0);
            v.all_courses = new student_courses[](0);
            return v;
        }
    }

    function Add_corse(
        uint id,
        string memory name,
        string memory weekly_hour,
        string memory level,
        string memory college
    ) public onlyAdmin(msg.sender) {
        course storage b = get_course[id];
        b.id = id;
        b.name = name;
        b.weekly_hour = weekly_hour;
        b.level = level;
        b.college = college;
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
        get_student[_id].warnnings.push(_warnning);
    }

    function Delet_emp(uint n) public onlyAdmin(msg.sender) {
        delete all_employees[n];
        delete get_emp[n];

        e_counter--;
    }

    function deleteStudent(uint256 _id) public onlyAdmin(msg.sender) {
        delete get_student[_id];

        uint256 lastIndex = all_students_id.length - 1;
        if (_id != all_students_id[lastIndex]) {
            all_students_id[_id] = all_students_id[lastIndex];
        }
        all_students_id.pop();

        s_counter--;
    }

    function deleteprof(uint256 _id) public onlyAdmin(msg.sender) {
        delete get_prof[_id];

        uint256 lastIndex = all_profs_id.length - 1;
        if (_id != all_profs_id[lastIndex]) {
            all_profs_id[_id] = all_profs_id[lastIndex];
        }
        all_profs_id.pop();

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
