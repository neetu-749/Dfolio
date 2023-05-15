// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract Portfolio {

    // to add project details
    struct Project{
        uint id;
        string name;
        string description;
        string image;
        string githubLink;
        string linkedinLink;
    }

    //to add education details
    struct Education {
        uint id;
        string date;
        string degree;
        string knowledgeAcquired;
        string institutionName;
    }

    //arrays to store projects and education information
    Project[3] public projects;
    Education[3] public educationDetails;

    //variable to store image links, description links, resme link
    string public imageLink="QmTqk7wpJ2TGTq6TzhvKZ2EZPAanBzHDuHJH4UCAn9134Q";
    string public description="Hello Amazing People";
    string public resumeLink="QmbRAecM7ZazTbSQuFawwEn9QUYzR5bZ1TvsKjE3M7veWC";
    uint projectCount;
    uint educationCount;
    address public manager;


    constructor(){
        manager=msg.sender;
    }

    modifier onlyManager(){
        require(manager==msg.sender, "You are not a manager");
        _;
    }
    
    // at the place of callback I didn't used memeory bcoz memory is costly (gas optimisation), also callback is used when we are not going to change the argument
    function insertProject(string calldata _name, string calldata _description, string calldata _image, string calldata _githubLink, string calldata _linkedinLink) external {
        // check project count is less than 3
        require(projectCount<3,"only 3 projects allowed");
        // now initialize it using project array
        projects[projectCount]=Project(projectCount, _name, _description, _image, _githubLink, _linkedinLink);
        projectCount++;
    }

    function changeProject(string calldata _name, string calldata _description, string calldata _image, string calldata _githubLink, string calldata _linkedinLink, uint _projectCount) external {
        require(_projectCount>=0 && _projectCount<3,"limit is only 3 projects");
        projects[projectCount]=Project(_projectCount, _name, _description, _image, _githubLink, _linkedinLink);
    }

    // to return the complete array
    // and as this is array so memory keyword is used
    function allProjects() external view returns(Project[3] memory){
        return projects;
    }

    function insertEducation(string calldata _date, string calldata _degree, string calldata _knowledgeAcquired, string calldata _institutionName) external {
        require(educationCount<3,"only 3 education allowed");
        educationDetails[educationCount]=Education(educationCount, _date, _degree, _knowledgeAcquired, _institutionName);
        educationCount++;
    }

     function changeEducation(string calldata _date, string calldata _degree, string calldata _knowledgeAcquired, string calldata _institutionName, uint _educationDetailsCount) external {
        require(_educationDetailsCount>=0 && _educationDetailsCount<3,"limit is only 3 educations");
        educationDetails[educationCount]=Education(_educationDetailsCount, _date, _degree, _knowledgeAcquired, _institutionName);
    }

    function allEducationDetails() external view returns(Education[3] memory){
        return educationDetails;
    }

    // to change image
    function changeImageLink(string calldata _imageLink) external onlyManager{
        imageLink = _imageLink;
    }

    // to change description
    function changeDescription(string calldata _description) external {
        description = _description;
    }

    // to change Resume link
    function changeResumeLink(string calldata _resumeLink) external onlyManager{
        resumeLink = _resumeLink;
    }

    // for donation/payment...to receive ethers(using payable)
    function donate() public payable {
        payable(manager).transfer(msg.value);
    }


}