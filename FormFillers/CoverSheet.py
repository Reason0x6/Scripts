import pdfrw
from datetime import date

print(pdfrw.__version__)

ANNOT_KEY = '/Annots'
ANNOT_FIELD_KEY = '/T'
ANNOT_VAL_KEY = '/V'
ANNOT_RECT_KEY = '/Rect'
SUBTYPE_KEY = '/Subtype'
WIDGET_SUBTYPE_KEY = '/Widget'
PDF_TEXT_APPEARANCE = pdfrw.objects.pdfstring.PdfString.encode('/Courier 28.00 Tf 0 g')

pdf_template = "Forms/Cover_Sheet.pdf"
pdf_output = input("Name of output PDF: ")
pdf_output += ".pdf"

CTitle = input("Course Title: ")
CCode = input("Course Code: ")
SNum = input("Student Num (No C): ")
ATitle = input("Assessment Title: ")
DDate = input("Due Date: ")
TGroup = input("Tutorial Group: ")
WCount = input("Word Count: ")
LName = input("Lecture Name: ")
EGranted = input("Extension Granted: [true/false] ")
EDate  = input("Extension Date: ")
ECheck = input("Education Check: [true/false] ")
SDate = input("Signed Date: ")
email = 'C' + SNum + '@uon.edu.au'

data_dict = {
    'First Name': 'Gavin',
    'Last Name': 'Austin',
    'Student Number': SNum,
    'Email': email,
    'Course Title': CTitle,
    'Course Code': CCode,
    'Campus Of Study': 'Callaghan',
    'Assessment Item Title': ATitle,
    'Due Date': DDate,
    'Tutorial Group': TGroup,
    'Word Count': WCount,
    'Lecture Name': LName,
    'Extension Date': EDate,
    'RadioButtonList[0]': EGranted,
    'Education Check': ECheck,
    'Signed Date': SDate
    
}

def fill_pdf(input_pdf_path, output_pdf_path, data_dict):
    template_pdf = pdfrw.PdfReader(input_pdf_path)
    for page in template_pdf.pages:
        annotations = page[ANNOT_KEY]
        for annotation in annotations:
            if annotation[SUBTYPE_KEY] == WIDGET_SUBTYPE_KEY:
                if annotation[ANNOT_FIELD_KEY]:
                    key = annotation[ANNOT_FIELD_KEY][1:-1]
                    if key in data_dict.keys():
                        if type(data_dict[key]) == bool:
                            if data_dict[key] == True:
                                annotation.update(pdfrw.PdfDict(
                                    AS=pdfrw.PdfName('Yes')))
                        else:
                            annotation.update(
                                pdfrw.PdfDict(V='{}'.format(data_dict[key]))
                            )
                            annotation.update(pdfrw.PdfDict(AP=''))
        annotation.update({'/DA': PDF_TEXT_APPEARANCE})
    pdfrw.PdfWriter().write(output_pdf_path, template_pdf)
    

fill_pdf(pdf_template, pdf_output, data_dict)