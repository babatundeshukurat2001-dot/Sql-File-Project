1. ProjectName → EmployeeName
(EmployeeName, Date) → ProjectName

2. Split off the FD that violates BCNF (ProjectName → EmployeeName):

Table 1: PROJECT_EMPLOYEE(ProjectName, EmployeeName)

Primary key / candidate key: ProjectName

Table 2: PROJECT_MEETING(ProjectName, Date)

Primary key / candidate key: (ProjectName, Date)
Foreign key: ProjectName → PROJECT_EMPLOYEE.ProjectName

3. Advantages:

Eliminates redundancy — the employee representing a project used to be repeated on every meeting-date row; now it's stored once.
Eliminates update anomalies — changing the employee who represents a project now requires updating a single row instead of many.
Eliminates insertion anomaly — you can record that an employee represents a project before any meeting has ever occurred.
Eliminates deletion anomaly — deleting the last recorded meeting for a project no longer erases the fact of who represents that project.

Disadvantage (an important one):

The decomposition is lossless but not dependency-preserving. The original FD (EmployeeName, Date) → ProjectName can no longer be enforced by a simple key constraint on either table alone — EmployeeName and Date don't appear together in the same table anymore. To check that constraint (e.g., that an employee didn't somehow get logged as attending two different project meetings on the same day), you'd need to join the two tables or add an application-level/trigger-based check. This is a known trade-off: it's not always possible to get a BCNF decomposition that is both lossless and dependency-preserving.



part b

1.Multivalued Dependencies

A student can belong to more than one club, have more than one sibling, and have more than one nickname — and these three facts are independent of one another (which club a student belongs to has nothing to do with which siblings or nicknames they have). This gives three independent MVDs:

StudentNumber →→ Club
StudentNumber →→ Sibling
StudentNumber →→ Nickname


2. StudentNumber → StudentName
StudentNumber → Dorm
StudentNumber → RoomType
RoomType      → DormCost      (cost depends on room type)
Club          → ClubCost      (all members of a club pay the same cost)


3.  Decomposition into BCNF and 4NF

Because there are multiple independent multivalued attributes (Club, Sibling, Nickname), they cannot be combined pairwise in one table without reintroducing spurious combinations — each needs its own table to reach 4NF. Combined with the ordinary FD violations of BCNF (RoomType→DormCost and Club→ClubCost each need splitting out), the decomposition is:

Table 1: STUDENT(StudentNumber, StudentName, Dorm, RoomType)

Primary key: StudentNumber
Foreign key: RoomType → ROOM_TYPE.RoomType

Table 2: ROOM_TYPE(RoomType, DormCost)

Primary key: RoomType

Table 3: CLUB(Club, ClubCost)

Primary key: Club

Table 4: STUDENT_CLUB(StudentNumber, Club)

Primary key: (StudentNumber, Club)
Foreign keys: StudentNumber → STUDENT.StudentNumber; Club → CLUB.Club

Table 5: STUDENT_SIBLING(StudentNumber, Sibling)

Primary key: (StudentNumber, Sibling)
Foreign key: StudentNumber → STUDENT.StudentNumber

Table 6: STUDENT_NICKNAME(StudentNumber, Nickname)

Primary key: (StudentNumber, Nickname)
Foreign key: StudentNumber → STUDENT.StudentNumber

Referential integrity constraints:

Every RoomType in STUDENT must exist in ROOM_TYPE.
Every Club in STUDENT_CLUB must exist in CLUB.
Every StudentNumber in STUDENT_CLUB, STUDENT_SIBLING, and STUDENT_NICKNAME must exist in STUDENT (typically cascade-delete, so removing a student removes their club/sibling/nickname rows too).
