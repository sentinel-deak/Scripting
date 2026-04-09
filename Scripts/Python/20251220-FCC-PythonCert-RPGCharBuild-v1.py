full_dot = '●'
empty_dot = '○'

# create a function to build a character
def create_character(name, strength, intelligence, charisma):
    
    # validate inputs for the name and stats
    if not isinstance(name, str):
        return 'The character name should be a string'
    if name == ' ' or name is None or name == '':
        return 'The character should have a name'
    if len(name) > 10:
        return 'The character name is too long'
    if ' ' in name:
        return 'The character name should not contain spaces'
    if not isinstance(strength, int) or not isinstance(intelligence, int) or not isinstance(charisma, int):
        return 'All stats should be integers'
    if strength < 1 or intelligence < 1 or charisma < 1:
        return 'All stats should be no less than 1'
    if strength > 4 or intelligence > 4 or charisma > 4:
        return 'All stats should be no more than 4'
    if strength + intelligence + charisma != 7:
        return 'The character should start with 7 points'
    
    # create the output in the terminal to provide a visual representation of the character's stats
    return f"""{name}\nSTR {full_dot * strength + empty_dot * (10 - strength)}\nINT {full_dot * intelligence + empty_dot * (10 - intelligence)}\nCHA {full_dot * charisma + empty_dot * (10 - charisma)}"""

# get user input and create a character
print(create_character((input('Enter character name: ')), int(input('Enter strength: ')), int(input('Enter intelligence: ')), int(input('Enter charisma: '))))