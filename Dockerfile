# Use the official .NET SDK base image with the desired version
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the application files to the container
COPY . /app

# Restore dependencies
RUN dotnet restore

# Build the application
RUN dotnet build --configuration Release --no-restore

# Publish the application
RUN dotnet publish --configuration Release --no-restore --output ./publish

# Set up the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

# Set the working directory for the runtime image
WORKDIR /app

# Copy the published application from the previous stage
COPY --from=build /app/publish .

# Expose the application port (if applicable)
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "YourApplication.dll"]

