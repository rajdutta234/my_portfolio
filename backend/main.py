from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import contact_routes
from db import engine, Base
import uvicorn

app = FastAPI(title="Portfolio Backend API")

@app.on_event("startup")
async def startup():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

# Configure CORS properly
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # In production, replace with specific frontend URL
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include Routers
app.include_router(contact_routes.router, prefix="/api")

@app.get("/")
async def root():
    return {"message": "Portfolio API is Operational", "status": "active"}

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
