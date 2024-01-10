import face_recognition
import json
import numpy as np

class Employee:
    """
    This is a base employee class
    """
    def __init__(self, employee: dict[str]):
        """
        Args:
            self,
            employee: which contains information of employee in dict.

        Returns:
        
        """
        self.id: int = employee["id"]
        self.name: str = employee["name"]
        self.base_image: str = employee["base_image"]

class ProRecogntion:
    """
    This is the main class, where it trains with all the images from the employee database.

    Args:
    None

    Returns:
        ProRecognition
    """
    def __init__(self) -> None:
        """
        This is the __init__ class
        """
        self.name: str = 'ProRecognition'
        self.version: float = 1.0
        self.face_db: list[np.ndarray] = []
        self.employee_db: list[dict] = [] 
        # Loads the face encodings of all the employees
        self.load()
    

    def get_encoding(self, image_path: str) -> list[np.ndarray]:
        """
        This method gives the face encoding details of the `base_image` which is provided.

        Args:
        self,
        image_path: str -> The path of the image

        Returns:
            FaceEncoding: NDArray
        """
        try:
            face = face_recognition.load_image_file(image_path)
        except Exception as e:
            print(e)
            return
        face_encodings = face_recognition.face_encodings(face)
        print(face_encodings.__len__())

        # Check if more than one face exists
        if (len(face_encodings) > 1):
            print(f"More than one face exists in this image: {image_path}")
            return
        return face_encodings[0]
    
    
    def load(self) -> None:
        """
        It loads all the employee images and gets the face encodings.

        Args:
        self,

        Returns
        None
        """
        with open("db/empdata.json", "r") as file:
            self.employee_db = json.load(file)
            file.close()

        for employee in self.employee_db:
            employee = Employee(employee)
            face_encoding = self.get_encoding(f"db/images/{employee.base_image}")
            self.face_db.append(face_encoding)

    def test_image(self, image_path: str) -> int:
        """
        This is a test_image method which takes a `image_path` to check whether it matches with either of the images that are passed before.

        Args:
        self,
        iamge_path: str -> Path of the image

        Returns:
            bool -> Matches or not
        """
        
        face_encoding = self.get_encoding(image_path)
        face_comparisons = face_recognition.compare_faces(self.face_db, face_encoding, tolerance=0.5) 
        if True in face_comparisons:
            return face_comparisons.index(True)
        return -1
    
    def image(self, image_path: str, json=True) -> Employee:
        """
        This is image method which takes a `image_path` to check whether it matches with either of the images that are passed before.

        Args:
        self,
        iamge_path: str -> Path of the image

        Returns:
            Employee -> Employee object
        """
        face_encoding = self.get_encoding(image_path)
        face_comparisons = face_recognition.compare_faces(self.face_db, face_encoding, tolerance=0.5) 
        if True in face_comparisons:
            valid = self.employee_db[face_comparisons.index(True)]
            if json:
                return valid
            return Employee(valid)
        return None
