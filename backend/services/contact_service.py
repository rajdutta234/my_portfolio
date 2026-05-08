from sqlalchemy.ext.asyncio import AsyncSession
from models.contact import ContactMessage

class ContactService:
    @staticmethod
    async def create_message(db: AsyncSession, name: str, email: str, message: str):
        new_message = ContactMessage(
            name=name,
            email=email,
            message=message
        )
        db.add(new_message)
        await db.commit()
        await db.refresh(new_message)
        return new_message
