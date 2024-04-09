CREATE TABLE [User] (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(MAX) NOT NULL,
    age INT,
    weight FLOAT,
    height FLOAT
);

CREATE TABLE ExerciseCategory (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(MAX) NOT NULL
);

CREATE TABLE Exercise (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(MAX) NOT NULL,
    description NVARCHAR(MAX),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES ExerciseCategory(id)
);

CREATE TABLE Nutrient (
    id INT PRIMARY KEY IDENTITY(1,1),
    calories FLOAT,
    protein FLOAT,
    fat FLOAT,
    carbohydrates FLOAT
);

CREATE TABLE Meal (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(MAX) NOT NULL,
    description NVARCHAR(MAX),
    allergens NVARCHAR(MAX),
    nutrient_id INT,
    FOREIGN KEY (nutrient_id) REFERENCES Nutrient(id)
);

CREATE TABLE Planner (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    meal_id INT,
    exercise_id INT,
    [date] DATE,
    FOREIGN KEY (user_id) REFERENCES [User](id),
    FOREIGN KEY (meal_id) REFERENCES Meal(id),
    FOREIGN KEY (exercise_id) REFERENCES Exercise(id)
);

DROP TABLE Planner;
DROP TABLE Meal;
DROP TABLE Nutrient;
DROP TABLE Exercise;
DROP TABLE ExerciseCategory;
DROP TABLE [User];


