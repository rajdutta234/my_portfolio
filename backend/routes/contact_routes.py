from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from pydantic import BaseModel, EmailStr
from db import get_db
from services.contact_service import ContactService

router = APIRouter(prefix="/contact", tags=["contact"])

class ContactRequest(BaseModel):
    name: str
    email: EmailStr
    message: str

@router.post("/send")
async def send_message(request: ContactRequest, db: AsyncSession = Depends(get_db)):
    try:
        message = await ContactService.create_message(
            db, 
            request.name, 
            request.email, 
            request.message
        )
        return {"status": "success", "message_id": message.id}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
