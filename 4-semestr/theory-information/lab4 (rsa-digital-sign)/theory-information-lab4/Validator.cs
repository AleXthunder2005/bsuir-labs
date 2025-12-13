using System.Windows.Forms;

namespace theory_information_lab4
{
    public class Validator
    {
        private const int MIN_PRIME_NUMBER = 2;
        private const int MAX_PRIME_NUMBER = int.MaxValue;
        private const int MIN_RSA_DEGREE = 2;

        public bool IsValidRSAPrimeComponent(string componentStr, string componentName)
        {
            int component;
            componentName = componentName.ToUpper();

            if (!int.TryParse(componentStr, out component))
            {
                ShowError($"Некорректное значение {componentName}! Введите простое число от {MIN_PRIME_NUMBER} до {MAX_PRIME_NUMBER}!");
                return false;
            }

            if ((component < MIN_PRIME_NUMBER) || (component > int.MaxValue))
            {
                ShowError($"Некорректное значение {componentName}! Введите простое число от {MIN_PRIME_NUMBER} до {MAX_PRIME_NUMBER}!");
                return false;
            }

            if (!MathTools.IsPrime(component))
            {
                ShowError($"Некорректное значение {componentName}! {componentName} должно быть простым!");
                return false;
            }

            return true;
        }


        public bool IsValidRSADegree(string degreeStr, long phi, string degreeName)
        {
            degreeName = degreeName.ToUpper();
            long MAX_RSA_DEGREE = phi - 1;
            long degree;

            if (!long.TryParse(degreeStr, out degree))
            {
                ShowError($"Некорректное значение {degreeName}! Введите целое число от {MIN_RSA_DEGREE} до {MAX_RSA_DEGREE}!");
                return false;
            }

            if ((degree < MIN_RSA_DEGREE) || (degree > MAX_RSA_DEGREE))
            {
                ShowError($"Некорректное значение {degreeName}! Введите целое число от {MIN_RSA_DEGREE} до {MAX_RSA_DEGREE}!");
                return false;
            }
            
            if (!MathTools.IsRelativelyPrime(degree, phi))
            {
                ShowError($"Некорректное значение {degreeName}! {degreeName} должно быть взаимопростым с Ф(r) = {phi}!");
                return false;
            }

            return true;
        }

        public bool IsValidE(string degreeStr)
        {
            long MAX_RSA_DEGREE = int.MaxValue;
            long degree;

            if (!long.TryParse(degreeStr, out degree))
            {
                ShowError($"Некорректное значение E! Введите целое число от {MIN_RSA_DEGREE} до {MAX_RSA_DEGREE}!");
                return false;
            }

            if ((degree < MIN_RSA_DEGREE) || (degree > MAX_RSA_DEGREE))
            {
                ShowError($"Некорректное значение E! Введите целое число от {MIN_RSA_DEGREE} до {MAX_RSA_DEGREE}!");
                return false;
            }

            return true;
        }


        public bool IsValidPAndQ(int p, int q)
        {
            if (q == p)
            {
                ShowError($"P и Q должны быть различными!");
                return false;
            }

            return true;
        }


        public bool IsValidSourceData(string data)
        {
            if (data == null)
            {
                ShowError($"Исходный файл не выбран!");
                return false;
            }

            return true;
        }

        private void ShowError(string message)
        {
            MessageBox.Show(message, "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

    }
}
